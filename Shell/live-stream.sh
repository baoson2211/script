#!/bin/bash
URL="rtmp://ase:11235813@aseserver.ddns.net:1935/live/stream"
CAM="/dev/video0"
if [ "$1" == "-h" ];
then
        echo " HELP: "
        echo
        echo " -h               --- show this help"
        echo " -x               --- show process id"
        echo " -p               --- run with preset values"
        echo
        echo " -s <arg2> <arg3> --- set in"
        echo "       \      \`------ address server"
        echo "        \`------------ device camera. See 'ls /dev/ | grep video'"
elif [ "$1" == "" ];
then
  echo "error: please run command './live-stream.sh -h'"
elif [ "$1" == "-p" ];
then
  ffmpeg -d -f v4l2 -i $CAM -s 1024x768 -b:v 1M -f flv -r 12.0 $URL 1>/dev/null 2>&1 & #>/dev/null &
elif [ "$1" == "-s" ];
then
  ffmpeg -d -f v4l2 -i /dev/$2 -s 320x240 -b:v 1M -f flv -r 12.0 rtmp://$3/live/stream 1>/dev/null 2>&1 & #>/dev/null &
elif [ "$1" == "-x" ];
then
  ps ax | grep ffmpeg
fi

#elif [ -b /dev/$1 ];
#then
#	if [ $? -eq 1];
#	then
#		echo "error: please run command 'ls /dev/ | grep video'"
#	fi
