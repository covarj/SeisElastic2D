#!/bin/bash
## data pre-processing work flow(cut, tapering, filtering, resample, taper .... )
source ./SU_process/process_par

# shift 
tshift=0.0 #-1.0 for Experiment IIC
# dt in microseconds
dt=$(echo $deltat*1000000 | bc -l )
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

# convert little endian to XDR or big-endian for SU application
if [[ $(echo " $tshift != 0.0" | bc -l ) == 1 ]]   || $SU_process && [[ $system_endian = "little_endian" ]] ; then
    suoldtonew <in_file> out_file
    cp out_file in_file
    sushift<in_file tmin=$tshift dt=$dt  |suchw key1=delrt a=0 >out_file
    cp out_file in_file
fi

if $SU_process; then

##scaling
#sugain<in_file tpow=$tpow >out_file
#cp out_file in_file

## cut function 
#suwind<in_file  tmin=$tmin tmax=$tmax >out_file
#cp out_file in_file

## taper
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
cp out_file in_file

# sumute
#sumute<in_file key=tracl xmute=1,395 tmute=0.5,3.0 below=1>out_file
#cp out_file in_file
## filter (bandpass)
#suwind<in_file>out_file itmin=0 itmax=8000
#cp out_file in_file

## scaling
#sugain <in_file panel=$panel agc=$agc wagc=$wagc>out_file
#cp out_file in_file

#suzero <in_file>out_file itmin=1000 itmax=4000
#cp out_file in_file

#sunormalize<in_file>out_file norm=$norm
#cp out_file in_file

#suzero <in_file itmin=$itmin1 itmax=$itmax1 >out_file
#cp out_file in_file

#suzero <in_file>out_file itmin=3000 itmax=4000
#cp out_file in_file 

sufilter f=$filt_freq amps=$amps <in_file>out_file
cp out_file in_file

#if [[ $1 = "Ux_file_single.su" ]]; then
#        sukill <in_file>out_file min=$min5 count=$count5
#        cp out_file in_file
#fi

## kill trace
#sukill <in_file>out_file min=$min1 count=$count1
#cp out_file in_file

#sukill <in_file>out_file min=$min2 count=$count2
#cp out_file in_file

#sukill <in_file>out_file min=$min5 count=$count5
#cp out_file in_file

## sumute
#suwind<in_file tmin=$tmin1 tmax=$tmax1 >out_file
#cp out_file in_file

## zero
#suzero <in_file>out_file itmin=$itmin1 itmax=$itmax1
#cp out_file in_file 

## normalize
#sunormalize <in_file>out_file norm=max
#cp out_file in_file

##scaling

## time window
#suzero <in_file>out_file itmin=$itmin0 itmax=$itmax0
#cp out_file in_file

# kill trace
#sukill <in_file>out_file min=1 count=23
#cp out_file in_file

#sukill <in_file>out_file min=45 count=1
#cp out_file in_file

#sukill <in_file>out_file min=109 count=1
#cp out_file in_file

## normalize
#sunormalize <in_file>out_file norm=$norm
#cp out_file in_file
## window
## cut function
#suwind<in_file  tmin=$tmin tmax=$tmax >out_file
#cp out_file in_file

## interpolation
#suresamp <in_file  nt=$NSTEP dt=$deltat >out_file
#cp out_file in_file

## taper again
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
cp out_file in_file

fi # end SU_process

# convert foreign to native/system endian
if [[ $(echo " $tshift != 0.0" | bc -l ) == 1 ]]   || $SU_process && [[ $system_endian = "little_endian" ]] ; then
    suswapbytes <in_file format=0 ns=$NSTEP >out_file
    cp out_file in_file
fi

## save final result
cp in_file $output_file

## clean up
rm -rf out_file in_file*

