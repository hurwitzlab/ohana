#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J fq2fa
#SBATCH -o fq2fa
#SBATCH --mail-user=kyclark@email.arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

set -u

FQ2FA="$HOME/bin/fq2fa.awk"

FILES=$(mktemp)
find . -name HOT\*.fastq > $FILES

OUT_DIR=$WORK/ohana/fasta

if [[ ! -d $OUT_DIR ]]; then
  mkdir -p $OUT_DIR
fi

i=0
while read FILE; do
  let i++
  printf "%3d: %s\n" $i $FILE
  OUT=$OUT_DIR/$(basename $FILE)
  $FQ2FA $FILE > $OUT
done < $FILES

echo Done.
