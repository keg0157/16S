#!/bin/sh
#Phixを除去する
for i in *merged.fastq
do
	c=`echo $i|cut -d "." -f 1`
	echo "Working on Phix $c".merged.fastq.N""
	/usr/bio/src/bowtie2-2.1.0/bowtie2 --no-hd --no-sq --no-unal -q -x /usr/bio/src/MiSeq16SPipe/phiX174.fasta.index -U $c".merged.fastq.N" -S $c".merged.fastq.N.sam"
done

for i in *merged.fastq
do
	c=`echo $i|cut -d "." -f 1`
	echo "Working on Phix2 $c".merged.fastq.N.sam""
	perl /usr/bio/src/MiSeq16SPipe/PhixRemoveMiU $c".merged.fastq.N" $c".merged.fastq.N.sam"
done
