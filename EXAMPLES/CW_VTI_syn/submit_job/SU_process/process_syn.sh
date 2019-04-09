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
## scaling
#sugain <in_file tpow=$tpow>out_file
#cp out_file in_file

## cut function 
#suwind<in_file  tmin=$tmin tmax=$tmax >out_file
#cp out_file in_file

## taper
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
cp out_file in_file

## scaling
#sugain <in_file panel=$panel agc=$agc wagc=$wagc>out_file
#cp out_file in_file

#sunormalize<in_file>out_file norm=$norm
#cp out_file in_file

## zero
#suzero <in_file itmin=$itmin1 itmax=$itmax1 >out_file
#cp out_file in_file

## sumute
## filter (bandpass)
#sufilter f=$filt_freq amps=$amps <in_file>out_file
#cp out_file in_file

## zero 2
#suzero <in_file itmin=3000 itmax=4000 >out_file
#cp out_file in_file

sufilter f=$filt_freq amps=$amps <in_file>out_file
cp out_file in_file

## kill trace
#if [[ $1="Ux" ]]; then
#        sukill <in_file>out_file min=$min5 count=$count5
#        cp out_file in_file
#fi

#sukill <in_file>out_file min=$min1 count=$count1
#cp out_file in_file

#sukill <in_file>out_file min=$min2 count=$count2
#cp out_file in_file

#sukill <in_file>out_file min=$min3 count=$count3
#cp out_file in_file

#sukill <in_file>out_file min=$min4 count=$count4
#cp out_file in_file

#sukill <in_file>out_file min=$min5 count=$count5
#cp out_file in_file

## normalize
#sunormalize<in_file>out_file norm=$norm
#cp out_file in_file
#suzero<in_file>out_file itmin=$itmin itmax=$itmax
#cp out_file in_file

#suzero<in_file>out_file itmin=$itmin0 itmax=$itmax0
#cp out_file in_file

## filter (bandpass)
#sufilter f=$filt_freq amps=$amps <in_file>out_file
#cp out_file in_file

## kill trace
#sukill <in_file>out_file min=1 count=23
#cp out_file in_file

#sukill <in_file>out_file min=45 count=1
#cp out_file in_file

#sukill <in_file>out_file min=109 count=1
#cp out_file in_file

## normalize
#sunormalize<in_file>out_file norm=$norm
#cp out_file in_file

## cut function
#suwind<in_file  tmin=$tmin tmax=$tmax >out_file
#cp out_file in_file

#sumute
#sumute<in_file key=tracl xmute=1,395 tmute=0.5,3.0 below=1>out_file
#cp out_file in_file

## taper again
sutaper<in_file tbeg=$taper_t1 tend=$taper_t2 tr1=$taper_x1 tr2=$taper_x2 ntr=$NREC min=0.0 taper=5>out_file
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

