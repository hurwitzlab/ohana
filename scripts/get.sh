#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J ohana
#SBATCH --mail-user=kyclark@email.arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

set -u

module load irods

#if [[ $# -ne 1 ]]; then
#  printf "Usage: %s file\n" $(basename $0)
#  exit 1
#fi
#FILE_LIST=$1

FILE_LIST='get-files.txt'
OUT_DIR=HOT

if [[ ! -d $OUT_DIR ]]; then
  mkdir $OUT_DIR
fi

#PARAM="$$.param"
#cat /dev/null > $PARAM

i=0
while read FILE; do
  let i++
  printf "%3d: %s\n" $i $FILE
  SAMPLE_NAME=$(basename $(dirname $FILE))
  DIR="$OUT_DIR/$SAMPLE_NAME"
  if [[ ! -d $DIR ]]; then
    mkdir -p $DIR
  fi

  iget $FILE $DIR/$(basename $FILE)
done < $FILE_LIST

echo Done.
