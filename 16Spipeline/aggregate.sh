# read_table作成
python /home/masuda/masuda/code/pipeline/script/correspond_read.py *aqv.fasta

#derep情報をテーブルに追加
python /home/masuda/masuda/code/pipeline/script/derep_append.py All.fasta.uc100 read_table

#97%clust情報をテーブルに追加
python /home/masuda/masuda/code/pipeline/script/clust97_append.py All.fasta.uc97 read_table_derep

#キメラ配列を同定
python /home/masuda/masuda/code/pipeline/script/Chimera.py All.fasta.fasta97.uchimedenovo All.fasta.fasta97.uchimeref

#キメラ判定されたリードの削除
python /home/masuda/masuda/code/pipeline/script/Chimera_remove.py Chimera_read read_table_derep_clust97

#OTUmatrix
/usr/bio/src/R-3.1.1/bin/R --vanilla --slave --args read_table_derep_clust97_remChimera < /home/masuda/masuda/code/pipeline/script/otu_matrix.R

#genus情報追加
python /home/masuda/masuda/code/pipeline/script/genus_append.py All.fasta.fasta97.RDPclassified read_table_derep_clust97_remChimera

#species情報追加
python /home/masuda/masuda/code/pipeline/script/species_append.py All.fasta.fasta97.living.parsed read_table_derep_clust97_remChimera_genus

#genusmatrix
/usr/bio/src/R-3.1.1/bin/R --vanilla --slave --args read_table_derep_clust97_remChimera_genus < /home/masuda/masuda/code/pipeline/script/genus_matrix.R

#speciesmatrix
/usr/bio/src/R-3.1.1/bin/R --vanilla --slave --args read_table_derep_clust97_remChimera_genus_species < /home/masuda/masuda/code/pipeline/script/species_matrix.R

