#!/bin/bash
cd workspace/bnoc

for i in 10 11 12
do
  ./srun_submit.sh "$i" > "srun_submit_$i.sh"
  sbatch -v "srun_submit_$i.sh"
done
