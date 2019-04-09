#!/bin/bash
#SBATCH --partition=geo      ### Partition
#SBATCH --job-name=HelloMPI  ### Job Name
#SBATCH --time=00:10:00      ### WallTime
#SBATCH --nodes=2            ### Number of Nodes
#SBATCH --ntasks-per-node=16  ### Number of tasks (MPI processes)
 
# failure to unset this will likely result in a hung job
unset I_MPI_PMI_LIBRARY
 
# avoid binding all tasks to single CPU core
export SLURM_CPU_BIND=none
 
# -IB to ensure comms use InfiniBand
srun -n 2 mpirun -np 16 --oversubscribe hostname
