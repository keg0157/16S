#!/bin/sh
#averageQuality
for i in *merged.fastq
do
c=`echo $i|cut -d "." -f 1`
	echo "AverageQuality of $c".merged.fastq.N.rem.trim2""
	perl /usr/bio/src/MiSeq16SPipe/Qual_Filter_FASTQ25 $c."merged.fastq.N.rem.trim2" /usr/bio/src/MiSeq16SPipe/ascii 25
done
