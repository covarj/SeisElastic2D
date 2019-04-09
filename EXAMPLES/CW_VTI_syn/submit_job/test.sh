#!/bin/bash

#echo $SLURM_PROCID
#env | grep SLURM
mpirun -np 16 --oversubscribe hostname
