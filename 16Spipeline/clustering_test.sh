#!/bin/sh
# fastaをcatする
cat ./*aqv.fasta > All.fasta

# 上32bit下64bit 100％マッチでderep
#/usr/bio/src/usearch7.0.1001_i86linux32 -derep_fulllength All.fasta -output All.fasta.fasta100_before -uc All.fasta.uc100 -sizeout
/usr/bio/src/usearch7.0.1090_i86linux64 -derep_fulllength All.fasta -output All.fasta.fasta100_before -uc All.fasta.uc100 -sizeout

#sizeoutする
cut -d ";" -f 1 All.fasta.fasta100_before > All.fasta.fasta100

#長さでソート
/usr/bio/src/usearch7.0.1090_i86linux64 --sortbylength All.fasta.fasta100 --output All.fasta.fasta100.sort

#97%でクラスタリング
/usr/bio/src/usearch7.0.1090_i86linux64 --cluster_smallmem All.fasta.fasta100.sort --strand both --id 0.97 --query_cov 0.8 --target_cov 0.8 --uc All.fasta.uc97 --centroids All.fasta.fasta97 --sizeout

#Chimera serch
/usr/bio/src/usearch7.0.1090_i86linux64 --uchime_ref All.fasta.fasta97 --db /usr/bio/src/gold.fa --uchimeout All.fasta.fasta97.uchimeref --strand plus
/usr/bio/src/usearch7.0.1090_i86linux64 --uchime_denovo All.fasta.fasta97 --uchimeout All.fasta.fasta97.uchimedenovo

# RDPClassify
java -Xmx1g -jar /usr/bio/src/rdp_classifier_2.6/dist/classifier.jar -c 0.5 -o All.fasta.fasta97.RDPclassified All.fasta.fasta97

# 種をblast
/usr/bio/src/blast-2.2.25/bin/blastall -p blastn -i All.fasta.fasta97 -d /sdat1/Kurokawa_Lab/Share/Inoue/LTPs111.compressed.fasta2 -o All.fasta.fasta97.living -m 8 -e 1e-8 -F F -a 4 -b 10 -v 10
perl /usr/bio/src/MiSeq16SPipe/ID_Len All.fasta.fasta97.living 97 150
perl /usr/bio/src/MiSeq16SPipe/Parse_Single All.fasta.fasta97.living 97.150



