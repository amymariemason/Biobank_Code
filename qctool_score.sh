#!/bin/bash
#SBATCH --time=1:0:0
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mem_bind=verbose,local
#SBATCH --error=GWAS1.err
#SBATCH --mem=8G
#SBATCH --job-name=qctool
#SBATCH --error=reports/qctool_%A.err
#SBATCH --output=reports/qctool_%A.out
#FILENAME: qctool_run2
#AUTHOR : Amy Mason
#PURPOSE: create subset of the UKbiobank bgen files as a single textfile
#INPUT: input_snps, a space seperated text file listing snps to extract. They must be in the form chr:pos with leading zeros if chr<10 ( eg 06:160493099)
#       output_name, what to call the output files
#       output_dir, where to put the output files (this will be set to the bgen folder in your project file)
#OUTPUT: one .bgen file, containing the extracted snps for that chr in .bgen format

. /etc/profile.d/modules.sh      
module load default-cardio       
module load slurm
module load use.own

module load gcc/5.2.0 
module load qctool2

date


qctool -g "${bgen1}" \
-s "${sample1}"
-risk-score "${risk1}"
-snp-match-fields position,alleles
-osample "${output1}"


date

