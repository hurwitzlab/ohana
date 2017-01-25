#!/bin/bash

FILES=$(mktemp)
find HOT -name \*readpool.fastq > $FILES

while read FILE; do
  DIR=$(dirname $FILE)
  SAMPLE=$(basename $DIR)
  BASENAME=$(basename $FILE '.fastq')
  NEW="$DIR/$SAMPLE.fastq"
  echo "$FILE = $NEW"
  mv $FILE $NEW
done < $FILES
