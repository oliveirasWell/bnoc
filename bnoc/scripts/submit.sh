#!/bin/bash
cd workspace/bnoc

rm -rf simg_images bnoc.simg output*
rclone sync cloud:/hpc/containers/simg_images simg_images
cp simg_images/bnoc.simg bnoc.simg

sbatch -v srun_submit1.sh
sbatch -v srun_submit12.sh

for i in 10 11
do
  ./srun_submit.sh "$i" > "srun_submit_$i.sh"
  sbatch -v "srun_submit_$i.sh"
done
