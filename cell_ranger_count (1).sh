#!/bin/bash 

#SBATCH --job-name=cell_ranger_aggr
#SBATCH --mem-per-cpu=150000 
#SBATCH --nodes=1
#SBATCH --time=30:00:00  
#SBATCH --share 
#SBATCH --partition=medium
#SBATCH --error=%j.%N.err.txt
#SBATCH --output=%j.%N.out.txt
#Next chunk you need are the things to happen 

#load modules 

module load shared
module load rc-base
module load  CellRanger/6.1.1

#info for cell ranger found here: 
#https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/tutorial_ct

#first is to download reference genome and all FASTQs.
#FASTQs are from Single Cell study as a comparison between P0 and P7 as time points in a cancer study 
#These are grouped in separate folders here: /data/user/empage/Mythreye/Single_Cell_FASTQ/


#I downloaded the reference with this command before the script: 
#wget https://cf.10xgenomics.com/supp/cell-exp/refdata-cellranger-GRCh38-3.0.0.tar.gz
#tar -zxvf refdata-cellranger-GRCh38-3.0.0.tar.gz
#Located here: /data/user/empage/Mythreye/Single_Cell_FASTQ/refdata-cellranger-GRCh38-3.0.0
#files named P0_S59_L001_I1_001.fastq.gz


#cell ranger command 
#cd /data/user/empage/Mythreye/Single_Cell_FASTQ/P0_FASTQ/
#cellranger count --id=run_count_P0  --sample=P0 --transcriptome=/data/user/empage/Mythreye/Single_Cell_FASTQ/refdata-cellranger-GRCh38-3.0.0 --fastqs=/data/user/empage/Mythreye/Single_Cell_FASTQ/P0_FASTQ/

#cd /data/user/empage/Mythreye/Single_Cell_FASTQ/P7_FASTQ/
#cellranger count --id=run_count_P7  --sample=P7 --transcriptome=/data/user/empage/Mythreye/Single_Cell_FASTQ/refdata-cellranger-GRCh38-3.0.0 --fastqs=/data/user/empage/Mythreye/Single_Cell_FASTQ/P7_FASTQ/

#do that step for each of the groups that you have.

#now you need to combine the cellranger files. There is a cell ranger function for this
#make the directory and csv beforehand.  the path for the file you need in the csv should be the same 

cd /data/user/empage/Mythreye/Single_Cell_FASTQ/P0_cellranger/run_cellranger_aggr_2/
cellranger aggr --id=P --csv=paths_cellranger_aggr.csv normalize=NONE --nosecondary