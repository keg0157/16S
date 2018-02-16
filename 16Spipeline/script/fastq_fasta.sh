#!/bin/sh
#FASTQ_FASTA
for i in *merged.fastq
	do
	c=`echo $i|cut -d "." -f 1`
	echo "Working on FASTQ_FASTA $c".merged.fastq.N.rem.trim2.aqv""
	perl /usr/bio/src/MiSeq16SPipe/FASTQ_FASTA $c."merged.fastq.N.rem.trim2.aqv"
done
