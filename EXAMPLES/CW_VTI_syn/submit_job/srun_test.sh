#!/bin/bash

#srun -n 2 --tasks-per-node=1 -p geo sh_test.sh
srun -n 2 --tasks-per-node=1 -p geo mpirun -np 16 --oversubscribe hostname
