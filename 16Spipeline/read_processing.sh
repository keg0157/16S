#!/bin/sh
# merge
for i in *R1_001.fastq
do
a=`echo $i|cut -d "_" -f 1,2,3`
#/usr/bio/src/MiSeq16SPipe/usearch7.0.1001_i86linux32 -fastq_mergepairs $a"_R1_001.fastq" -reverse $a"_R2_001.fastq" -fastq_truncqual 7 -fastqout $a".merged.fastq" -fastq_allowmergestagger
#/usr/bio/src/MiSeq16SPipe/usearch7.0.1001_i86linux32 -fastq_mergepairs $a"_R1_001.fastq" -reverse $a"_R2_001.fastq" -fastq_truncqual 10 -fastqout $a".merged.fastq" -fastq_allowmergestagger
done

# remN
for i in *merged.fastq
do
        c=`echo $i|cut -d "." -f 1`
        #echo "N lost$c"
        perl /usr/bio/src/MiSeq16SPipe/Exclude_N_Fastq2 $c".merged.fastq"
done

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

# remAdp
for i in *merged.fastq
do
        c=`echo $i|cut -d "." -f 1`
        echo "Working on Adapter $c".merged.fastq.N.rem""
        /usr/bio/src/cutadapt-1.2.1/bin/cutadapt -g CTACGGGGGGCAGCAG -O 18 -m 250 -M 500 -o $c".merged.fastq.N.rem.trim" -q 17 -f fastq $c".merged.fastq.N.rem"
        /usr/bio/src/cutadapt-1.2.1/bin/cutadapt -a AGATACCCCGGTAGTCC -O 13 -e 0.3 -m 250 -M 500 -o $c".merged.fastq.N.rem.trim2" -q 17 -f fastq $c".merged.fastq.N.rem.trim"
done

#averageQuality
for i in *merged.fastq
do
c=`echo $i|cut -d "." -f 1`
        echo "AverageQuality of $c".merged.fastq.N.rem.trim2""
        perl /usr/bio/src/MiSeq16SPipe/Qual_Filter_FASTQ25 $c."merged.fastq.N.rem.trim2" /usr/bio/src/MiSeq16SPipe/ascii 25
done

#FASTQ_FASTA
for i in *merged.fastq
        do
        c=`echo $i|cut -d "." -f 1`
        echo "Working on FASTQ_FASTA $c".merged.fastq.N.rem.trim2.aqv""
        perl /usr/bio/src/MiSeq16SPipe/FASTQ_FASTA $c."merged.fastq.N.rem.trim2.aqv"
done
