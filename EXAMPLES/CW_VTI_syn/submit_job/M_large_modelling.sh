#!/bin/bash
#SBATCH -J Marmousi_temp
#SBATCH --nodes=32
#SBATCH --ntasks-per-node=1
#SBATCH -o slurm%j.log
#SBATCH -t 00:30:00
#SBATCH -A w18_trust

#SBATCH --qos=interactive

ulimit -s unlimited

source ./parameter
export user=$(whoami)

if [ $system == 'slurm' ]; then
    # Submit directory
    export SUBMIT_DIR=$SLURM_SUBMIT_DIR
    echo "$SLURM_JOB_NODELIST"  >  ./job_info/NodeList
    echo "$SLURM_JOBID"  >  ./job_info/JobID
elif [ $system == 'pbs' ]; then
    # Submit directory
    export SUBMIT_DIR=$PBS_O_WORKDIR
    echo "$PBS_NODEFILE"  >  ./job_info/NodeList
    echo "$PBS_JOBID"  >  ./job_info/JobID
fi
cd $SUBMIT_DIR
#################### input parameters ###################################################
# directories
export SCRIPTS_DIR="$package_path/scripts"
export SUBMIT_RESULT="$SUBMIT_DIR/RESULTS/$job/Scale${Wscale}_${measurement_list}_${misfit_type_list}"     # final results
if [ -z "$working_path" ]; then
    export working_path=$SUBMIT_DIR
fi
export WORKING_DIR="$working_path/$Job_title/"  # directory on local nodes, where specfem runs

echo "Submit job << $Job_title >> in : $SUBMIT_DIR  "
echo "Working directory: $WORKING_DIR"
echo "FINAL results in :  $SUBMIT_RESULT"
#########################################################################################
STARTTIME=$(date +%s)
echo "start time is :  $(date +"%T")"

if $ReStart; then
    echo
    echo "Re-Starting job ..." 
    echo "Clean up result/working directories ..."
    rm -rf $SUBMIT_RESULT $WORKING_DIR
    mkdir -p $SUBMIT_RESULT $WORKING_DIR
else
    echo
    echo "Continue with current job ..."
fi 

echo 
echo "prepare data ..."
velocity_dir=$target_velocity_dir
if [ $system == 'slurm' ]; then
    srun -n $ntasks -c $NPROC_SPECFEM -l -W 0 $SCRIPTS_DIR/prepare_data.sh $velocity_dir 2> ./job_info/error_target
elif [ $system == 'pbs' ]; then
    pbsdsh -v $SCRIPTS_DIR/prepare_data.sh $velocity_dir
fi

## SAVE
cp -r $SUBMIT_DIR/job_info/output $SUBMIT_RESULT/
cp -r $SUBMIT_DIR/parameter $SUBMIT_RESULT/

echo
echo " clean up local nodes (wait) ...... "
if ! $DISPLAY_DETAILS ; then
    rm -rf $working_path/$Job_title
fi

ENDTIME=$(date +%s)
Ttaken=$(($ENDTIME - $STARTTIME))
echo
echo "finish time is : $(date +"%T")" 
echo "RUNTIME is :  $(($Ttaken / 3600)) hours ::  $(($(($Ttaken%3600))/60)) minutes  :: $(($Ttaken % 60)) seconds."

echo
echo "******************well done*******************************"
