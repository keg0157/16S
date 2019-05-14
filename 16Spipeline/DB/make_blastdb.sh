#DB作成
#makeblastdb -in ./current_Bacteria_unaligned.fa -dbtype nucl -out RDP.fasta.index
makeblastdb -in ./LTPs132_SSU_compressed.fasta_forblast -dbtype nucl -out LTPs132_SSU_compressed.fasta
#実行
blastn -query test.merged.fastq.fasta -db LTPs132_SSU_compressed_fasta -out LTP_res -evalue 1e-8 -outfmt 6 -num_alignments 10 -num_threads 4 -num_descriptions 10

