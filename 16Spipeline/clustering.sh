#!/bin/sh

dir=/nfshome/s20019/misc/NGS/16SrRNA-master/16Spipeline

echo "Clustering"
cat ./*aqv.fasta > Allsample.fasta

# derep
${dir}/script/usearch7.0.1090_i86linux32 -derep_fulllength Allsample.fasta -output Allsample.fasta.uc100 -uc uc100_res #-sizeout

#長さでソート
${dir}/script/usearch7.0.1090_i86linux32 --sortbylength Allsample.fasta.uc100 --output Allsample.fasta.uc100.sorted

#97%でクラスタリング
${dir}/script/usearch7.0.1090_i86linux32 --cluster_smallmem Allsample.fasta.uc100.sorted --strand both --id 0.97 --query_cov 0.8 --target_cov 0.8 --uc uc97_res --centroids Allsample.fasta.uc97 --sizeout

echo "Searching ChimeraRead"
# Chimera search reference
${dir}/script/usearch7.0.1090_i86linux32 --uchime_ref Allsample.fasta.uc97 --db ${dir}/DB/gold.fa --uchimeout uchimeref_res --strand plus
# Chimera search denovo
${dir}/script/usearch7.0.1090_i86linux32 --uchime_denovo Allsample.fasta.uc97 --uchimeout uchimedenovo_res

echo "Running RDPclassifier"
# RDPClassify
java -Xmx1g -jar /nfsroot/home/s20019/tools/rdp_classifier_2.12/dist/classifier.jar -c 0.5 -o Allsample.fasta.uc97.RDPclassified Allsample.fasta.uc97

echo "Running blastn"
# blast to LTP
blastn -query Allsample.fasta.uc97 -db ${dir}/DB/RDP.fasta.index -out Allsample.fasta.uc97.RCPspecies -outfmt 6 -evalue 1e-8 -num_alignments 10 -num_threads 4 #-num_descriptions 10
#blastn -query Allsample.fasta.uc97 -db ${dir}/DB/LTPs132_SSU_compressed.fasta -out Allsample.fasta.uc97.LTP -outfmt 6 -evalue 1e-8 -num_alignments 10 -num_threads 4 #-num_descriptions 10
# parse Topscore
python ${dir}/script/parse_TopScore.py Allsample.fasta.uc97.LTP
