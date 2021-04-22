#!/bin/bash
#SBATCH -J bnoc # Job name
#SBATCH -o %j.out # Name of stdout output file (%j expands to jobId)
#SBATCH -N 1 # Total number of nodes requested
#SBATCH -t 01:30:00 # Run time (hh:mm:ss) - 1.5 hours
#SBATCH --partition=fast
#SBATCH --mail-user=wellington.oliveira@estudante.ufscar.br
#SBATCH --mail-type=ALL
#SBATCH --account=usuario

echo "Configurando ambiente..."

module purge
module load singularity

echo "Executando..."

srun --mpi=pmi2 singularity run --bind=/var/spool/slurm:/var/spool/slurm bnoc.simg /opt/conda/envs/mfbn/bin/python /opt/bnoc.py -cnf /opt/bipartite-time-ncol.json