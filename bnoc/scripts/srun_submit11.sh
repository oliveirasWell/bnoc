#!/bin/bash
#SBATCH -J bnoc # Job name
#SBATCH -o %j.out # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1 # Total number of nodes requested
#SBATCH -t 01:30:00 # Run time (hh:mm:ss) - 1.5 hours
#SBATCH --partition=normal
#SBATCH --mail-user=wellington.oliveira@estudante.ufscar.br
#SBATCH --mail-type=ALL
#SBATCH --mem=320000MB
#SBATCH --account=usuario

. send_notification.sh

echo "Setup Environment..."

module purge
module load singularity


sendOutputFile() {
  mv "${SLURM_JOB_ID}.out" "${SLURM_JOB_ID}.txt"
  sendFile "${SLURM_JOB_ID}.txt"
  rm -rf "${SLURM_JOB_ID}.out" "${SLURM_JOB_ID}.txt"
}

sendMsg "Job ${SLURM_JOB_ID} starting"

echo "Starting..."

srun singularity run --bind=/var/spool/slurm:/var/spool/slurm bnoc.simg /opt/conda/envs/mfbn/bin/python /opt/bnoc.py -cnf /opt/bipartite-time-ncol11.json

retCode=$?
if [[ "$retCode" -ne 0 ]]; then
  sendErr
  sendOutputFile
  exit 1
fi

echo "Finished!"

sendOutputFile
sendFile output/bipartite-time-ncol-inf.json
tar -cvf  "${SLURM_JOB_ID}.tar" output/bipartite-time-ncol.ncol
sendFile "${SLURM_JOB_ID}.tar"

sendMsg "Job ${SLURM_JOB_ID} finished :D"