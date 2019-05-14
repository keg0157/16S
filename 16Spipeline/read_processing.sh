#!/bin/sh
dir=/nfshome/s20019/misc/NGS/16SrRNA-master/16Spipeline
#bowtie2-build -f ${dir}/DB/phiX174.fa ${dir}/DB/phiX174.fasta.index

for i in *fastq
do
		a=`echo ${i}|cut -d "_" -f 1,2,3`
        c=`echo ${i}|cut -d "." -f 1`
		echo "Working sample is ${c}"
		
		#echo "Making merged fastq"
		#${dir}/script/usearch7.0.1090_i86linux32 -fastq_mergepairs ${a}_R1_001.fastq -reverse ${a}_R2_001.fastq -fastq_truncqual 7 -fastqout ${a}.merged_fastq -fastq_allowmergestagger
        
		echo "Removing N"
		python ${dir}/script/remN.py ${i}
        
		echo "Removing Phix"
        bowtie2 --no-hd --no-sq --no-unal -q -x ${dir}/DB/phiX174.fasta.index -U ${i}.N -S ${c}_phix.sam
		python ${dir}/script/delete_mapped_fastq.py ${i}.N ${c}_phix.sam
        
		echo "Removing Adapter"
        cutadapt -g CTACGGGGGGCAGCAG -O 18 -m 250 -M 500 -o ${i}.N.rem.trim -q 17 -f fastq ${i}.N.rem
        cutadapt -a GGGGAGTACGACCGCAA -O 13 -e 0.3 -m 250 -M 500 -o ${i}.N.rem.trim2 -q 17 -f fastq ${i}.N.rem.trim
        
		echo "Filtering read by quality"
		python ${dir}/script/QF.py ${i}.N.rem.trim2 ${dir}/DB/ascii
        
		echo "Translate fastq2fasta"
		python ${dir}/script/convert_fq2fa.py ${i}.N.rem.trim2.aqv 
        
done

