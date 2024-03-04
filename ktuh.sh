#! /bin/bash

if [ $# -lt 5 ]
then
    echo "USAGE: $0 <Suffix=m4a|mp3|???> <OutDir> <Hours> <Minutes> <Seconds>"
    exit -1
fi

Suffix=$1
OutDir=$2
hh=$3
mm=$4
ss=$5

dt=$(date +"%Y-%m-%d_%H-%M-%S")
OutBase=${OutDir}/ktuh_${dt}
OutName=${OutBase}.${Suffix}

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
