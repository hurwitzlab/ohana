#!/bin/bash

set -u

FILES=$(mktemp)
find . -name HOT\*.fastq > $FILES

OUT_DIR=$WORK/ohana/mash/sketches

if [[ ! -d $OUT_DIR ]]; then
  mkdir -p $OUT_DIR
fi

i=0
while read FILE; do
  let i++
  OUT_FILE=$(basename $FILE)
  if [[ ! -e $OUT_FILE ]]; then
    printf "%3d: %s -> $OUT_FILE\n" $i $FILE
    mash sketch -o "$OUT_DIR/$OUT_FILE" $FILE
  fi
done < $FILES

echo Done sketching.

rm $FILES
