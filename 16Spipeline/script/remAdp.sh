#!/bin/sh

for i in *merged.fastq
do
	c=`echo $i|cut -d "." -f 1`
	echo "Working on Adapter $c".merged.fastq.N.rem""
	/usr/bio/src/cutadapt-1.2.1/bin/cutadapt -g NNCGATAGAGTTTGATCCTGGCTCAG -O 18 -m 250 -M 400 -o $c".merged.fastq.N.rem.trim" -q 17 -f fastq $c".merged.fastq.N.rem"
	/usr/bio/src/cutadapt-1.2.1/bin/cutadapt -a ACTCCTACGGGAGGCAGCANN -O 13 -e 0.3 -m 250 -M 400 -o $c".merged.fastq.N.rem.trim2" -q 17 -f fastq $c".merged.fastq.N.rem.trim"
done

#Fのみ使う場合(Toyama)
#for i in *merged.fastq
#do
#	c=`echo $i|cut -d "." -f 1`
#	echo "Working on Adapter $c".merged.fastq.N.rem""
#	/usr/bio/src/cutadapt-1.2.1/bin/cutadapt -g TACGGGGGGCAGCAG -O 13 -m 200 -M 400 -o $c".merged.fastq.N.rem.trim" -q 17 -f fastq $c".merged.fastq.N.rem"
#done

