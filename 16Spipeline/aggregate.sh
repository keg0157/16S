# read_table作成
dir=/nfshome/s20019/misc/NGS/16SrRNA-master/16Spipeline

python ${dir}/script/correspond_read.py *aqv.fasta

#derep情報をテーブルに追加
python ${dir}/script/derep_append.py uc100_res read_table

#97%clust情報をテーブルに追加
python ${dir}/script/clust97_append.py uc97_res read_table_derep

#キメラ配列を同定 ann リードの削除
python ${dir}/script/Chimera.py uchimedenovo_res uchimeref_res
python ${dir}/script/Chimera_remove.py Chimera_read read_table_derep_clust97

# OTUテーブル作成
R --vanilla --slave --args read_table_derep_clust97_remChimera < ${dir}/script/otu_matrix.R

# genus情報追加 and テーブル作成
python ${dir}/script/genus_append.py Allsample.fasta.uc97.RDPclassified read_table_derep_clust97_remChimera
R --vanilla --slave --args read_table_derep_clust97_remChimera_genus < ${dir}/script/genus_matrix.R

# species情報追加 and テーブル作成
python ${dir}/script/species_append.py Allsample.fasta.uc97.LTP.id_len_filtered.parsed read_table_derep_clust97_remChimera_genus
python ${dir}/script/make_speciesmatrix.py read_table_derep_clust97_remChimera_genus_species
