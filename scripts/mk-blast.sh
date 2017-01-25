#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -p normal
#SBATCH -t 10:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J mkblast
#SBATCH --mail-user=kyclark@email.arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

set -u

module load blast

IN_DIR=HOT
OUT_DIR=blast

if [[ ! -d $OUT_DIR ]]; then
  mkdir -p $OUT_DIR
fi

#echo Contigs
#rm -rf $OUT_DIR/contigs*
#CONTIGS_FA=$OUT_DIR/contigs.fa
#cat $(find $IN_DIR -type f -name contigs.fa) > $CONTIGS_FA

#CONTIGS_LIST=$(mktemp)
#find $IN_DIR -type f -name contigs.fa >> $CONTIGS_LIST
#cat /dev/null > $CONTIGS_FA
#i=0
#while read FILE; do
#  let i++
#  printf "%3d: Converting %s\n" $i $(basename $(dirname $FILE))
#  fq2fa.awk $FILE >> $CONTIGS_FA
#done < $CONTIGS_LIST

#makeblastdb -in $CONTIGS_FA -dbtype nucl -title ohana_contigs -out $OUT_DIR/contigs

#rm $CONTIGS_LIST
#rm $CONTIGS_FA

echo Genes
GENES_FA=$IN_DIR/genes.fa
cat $(find $IN_DIR -type f -name genes.fna) > $GENES_FA
makeblastdb -in $GENES_FA -dbtype nucl -title ohana_genes -out $OUT_DIR/genes
rm $GENES_FA

echo Proteins
PROT_FA=$IN_DIR/proteins
cat $(find $IN_DIR -type f -name proteins.faa) > $PROT_FA
makeblastdb -in $PROT_FA -dbtype prot -title ohana_proteins -out $OUT_DIR/proteins
rm $PROT_FA

echo Done.
