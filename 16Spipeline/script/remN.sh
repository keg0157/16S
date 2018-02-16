#!/bin/sh
for i in *merged.fastq 
do
	c=`echo $i|cut -d "." -f 1`
	#echo "N lost$c"
	perl /usr/bio/src/MiSeq16SPipe/Exclude_N_Fastq2 $c".merged.fastq"
done
