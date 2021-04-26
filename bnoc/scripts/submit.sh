#!/bin/bash
cd workspace/bnoc

rm -rf simg_images bnoc.simg
cp simg_images/bnoc bnoc.simg
rclone sync cloud:/hpc/containers/simg_images /workspace/bnoc/simg_images

for i in 6 7 8 9 10 11 12
do
  ./srun_submit.sh "$i" > "srun_submit_$i.sh"
  sbatch -v "srun_submit_$i.sh"
done
