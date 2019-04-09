#!/bin/bash
## data pre-processing work flow(cut, tapering, filtering, resample, taper .... )
source ./SU_process/process_par

## cut
tmin=0
tmax=$(echo $(echo "$deltat $NSTEP" | awk '{ print $1*($2-1) }'))
## interpolation
sampling_rate=$(echo $(echo "$deltat" | awk '{ print 1.0/$1 }'))
#taper parameters
taper_t1=$(echo $(echo "$tmax $max_percentage 1000" | awk '{ print int($1*$2*$3) }'))
taper_t2=${taper_t1}
taper_x1=0
taper_x2=${taper_x1}

###########################################################################################################
input_file=$1
output_file=$2
cp $input_file in_file

if $SU_process; then
# convert little endian to XDR or big-endian for SU application
if [[ $system_endian = "little_endian" ]]; then
        suoldtonew <in_file> out_file
        cp out_file in_file
fi

## taper again
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
cp out_file in_file

## filter (bandpass)
sufilter f=$filt_freq amps=$amps <in_file>out_file
cp out_file in_file

## taper
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
cp out_file in_file

## cut function 
suwind<in_file  tmin=$tmin tmax=$tmax >out_file
cp out_file in_file

## scaling
sugain <in_file scale=$scale>out_file
cp out_file in_file


# convert foreign to native/system endian 
if [[ $system_endian = "little_endian" ]]; then
    suswapbytes <in_file format=0 ns=$NSTEP >out_file
    cp out_file in_file
fi

fi # end SU_process

## save final result
cp in_file $output_file

## clean up
rm -rf out_file in_file*

