#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J md5chk
#SBATCH --mail-user=kyclark@email.arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

set -u

echo Started $(date)
./check-md5.pl6
echo Ended $(date)
