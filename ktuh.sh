#! /bin/bash

if [ $# -lt 5 ]
then
    echo "USAGE: $0 <Suffix=m4a|mp3|???> <Prefix> <Hours> <Minutes> <Seconds>"
    exit -1
fi

Suffix=$1
Prefix=$2
hh=$3
mm=$4
ss=$5

dt=$(date +"%Y-%m-%d_%H-%M-%S")
OutBase=${Prefix}_${dt}
OutName=${OutBase}.${Suffix}
OutDir=$(dirname ${OutName})

Flags=""
if [ "${Suffix}" == "m4a" ]; then
   Flags="-codec copy"
fi

TimeInSeconds=$((${ss} + 60*(${mm} + 60*${hh})))

#echo ${OutName}
#echo ${Flags}
#echo ${TimeInSeconds}
#exit

mkdir -p ${OutDir}
date > ${OutBase}.start.txt
ffmpeg -t ${TimeInSeconds} -i https://stream.ktuh.org:8001/stream ${Flags} ${OutName} 1> /dev/null 2>&1 &
