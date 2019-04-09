#!/bin/bash

echo 
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo
echo " source parameter file ..." 
source ./parameter

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo
echo " Copy specfem executavles ..."
rm -rf bin
mkdir bin
cp -r $specfem_path/bin/* ./bin/

echo 
echo " create new job_info file ..."
rm -rf job_info
mkdir job_info

echo 
echo " create result file ..."
mkdir -p RESULTS

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo
echo

workflow_DIR="$package_path/workflow"

if [ "$job" ==  "modeling" ] || [ "$job" ==  "Modeling" ]
then
    echo " ########################################################"
    echo " Forward modeling .." 
    echo " ########################################################"
    cp $workflow_DIR/Modeling.sh $Job_title.sh

elif [ "$job" ==  "kernel" ] || [ "$job" ==  "Kernel" ]
then
    echo " ########################################################"
    echo " Adjoint Inversion .." 
    echo " ########################################################"
#    cp $workflow_DIR/Kernel_pwy_source_attenuation.sh $Job_title.sh
    cp $workflow_DIR/Kernel_iso.sh $Job_title.sh

elif [ "$job" ==  "inversion" ] || [ "$job" ==  "FWI" ]
then
    echo " ########################################################"
    echo " Adjoint Inversion .." 
    echo " ########################################################"
    cp $workflow_DIR/AdjointInversion_iso.sh $Job_title.sh
#    cp $workflow_DIR/AdjointInversion_pwy_source_attenuation_only.sh $Job_title.sh
else
    echo "Wrong job: $job"
fi

echo
echo " renew parameter file ..."
cp -r $package_path/SRC/seismo_parameters.f90 ./bin/
cp -r $package_path/SRC/seism_uti_module.f90 ./bin/
cp -r $package_path/SRC/corr_focus_mod.f90 ./bin/
cp -r $package_path/SRC/myMath_module.f90 ./bin/
cp -r $package_path/SRC/nrutil.f90 ./bin/
cp -r $package_path/SRC/nrtype.f90 ./bin/
cp -r $package_path/SRC/precision_module.f90 ./bin/
cp -r $package_path/SRC/myString_mod.f90 ./bin/

cp $package_path/scripts/renew_parameter.sh ./
sh ./renew_parameter.sh

echo 
echo " complile source codes ... "
rm -rf *.mod make_file
cp $package_path/make/make_$compiler ./make_file
cp $package_path/lib/constants.mod ./
FILE="make_file"
sed -e "s#^SRC_DIR=.*#SRC_DIR=$package_path/SRC#g"  $FILE > temp;  mv temp $FILE
make -f make_file clean
make -f make_file

echo 
echo " edit request nodes and tasks ..."
nproc=$NPROC_SPECFEM
nodes=$(echo $(echo "$ntasks $nproc $max_nproc_per_node" | awk '{ print $1*$2/$3 }') | awk '{printf("%d\n",$0+=$0<0?0:0.999)}')
ncores=$(echo "$ntasks $nproc" | awk '{ print $1*$2 }')
echo " Request $nodes nodes, $ntasks tasks, $nproc cpus per task "

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo

echo "submit job"
echo
if [ $system == 'slurm' ]; then
    echo "slurm system ..."
    echo "sbatch -J $job -p $queue -N $nodes -n $ncores -t $WallTime -e job_info/error -o job_info/output $Job_title.sh"
    sbatch -J $job -p $queue -N $nodes -n $ncores -t $WallTime -e job_info/error -o job_info/output $Job_title.sh

elif [ $system == 'pbs' ]; then
    echo "pbs system ..."
    echo
    qsub -q $queue -l nodes=$nodes:ppn=$max_nproc_per_node -l --walltime=$WallTime -e job_info/error -o job_info/output  $Job_title.sh
fi
echo
