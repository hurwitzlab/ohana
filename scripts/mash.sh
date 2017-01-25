#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J ohanamash
#SBATCH -o ohanamash
#SBATCH --mail-user=kyclark@email.arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

set -u

./mk-mash.sh

#FILES=$(mktemp)
#find . -name \*readpool.fastq > $FILES
#
#OUT_DIR=$WORK/ohana/mash/sketches
#
#if [[ ! -d $OUT_DIR ]]; then
#  mkdir -p $OUT_DIR
#fi
#
#PARAM="$$.param"
#cat /dev/null > $PARAM
#
#i=0
#while read FILE; do
#  let i++
#  printf "%3d: %s\n" $i $FILE
#  echo "mash sketch -o $OUT_DIR -l $FILE" >> $PARAM
#done < $FILES
#
#echo "Starting parallel job... $(date)"
#export LAUNCHER_DIR=$HOME/src/launcher
#export LAUNCHER_PPN=4
#export LAUNCHER_WORKDIR=$OUT_DIR
#time $LAUNCHER_DIR/paramrun SLURM $LAUNCHER_DIR/init_launcher $LAUNCHER_WORKDIR $PARAM
#echo "Finished parallel $(date)"
#
#rm $FILES
#rm $PARAM
