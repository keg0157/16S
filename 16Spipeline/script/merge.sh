#!/bin/sh
for i in *R1_001.fastq
do
a=`echo $i|cut -d "_" -f 1,2,3`
/usr/bio/src/MiSeq16SPipe/usearch7.0.1001_i86linux32 -fastq_mergepairs $a"_R1_001.fastq" -reverse $a"_R2_001.fastq" -fastq_truncqual 10 -fastqout $a".merged.fastq" -fastq_allowmergestagger
done
