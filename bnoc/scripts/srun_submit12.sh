#!/bin/bash
#SBATCH -J bnoc_12 # Job name
#SBATCH -o %j.out # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1 # Total number of nodes requested
#SBATCH -t 2:00:00
#SBATCH --partition=normal
#SBATCH --mail-user=wellington.oliveira@estudante.ufscar.br
#SBATCH --mail-type=ALL
#SBATCH --mem=354500MB
#SBATCH --account=usuario

. send_notification.sh

echo "Setup Environment..."

module purge
module load singularity

sendOutputFile() {
  cp "${SLURM_JOB_ID}.out" "${SLURM_JOB_ID}_12.txt"
  sendFile "${SLURM_JOB_ID}_12.txt"
}

sendMsg "Job ${SLURM_JOB_ID} starting"

echo "Starting..."

srun --mpi=pmix_v2 singularity run --bind=/var/spool/slurm:/var/spool/slurm bnoc.simg /opt/conda/envs/mfbn/bin/python /opt/bnoc.py -cnf "/opt/bipartite-time-ncol12.json"
retCode=$?
echo "$retCode"
if [[ "$retCode" -ne 0 ]]; then
  echo "An error accrued"
  sendErr
  sendOutputFile
  exit 1
fi
echo "Finished!"

sendOutputFile
tar -cvf  "${SLURM_JOB_ID}_12.tar" "output_12"
rclone copy "${SLURM_JOB_ID}_12.tar" "cloud:hpc/containers/outputs/"

sendMsg "Job ${SLURM_JOB_ID} finished :D"
