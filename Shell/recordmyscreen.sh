#!/bin/bash
if [ "$1" == "-h" ] || [ "$1" == "--help" ];
then
        echo " Instructions: "
        echo " -h                    show this help"
        echo " -a   --audio          record audio"
        echo " -na  --no-audio       no record audio"
        echo " -e   --extension      set container mkv or mp4"
        echo " -p   --preset         preset output /tmp/out.{mkv - mp4}"
        echo " -o   --output         set output destination"
        echo ""
        echo " Example:"
        echo " ./recordmyscreen.sh -a -e mp4 -p"
        echo " ./recordmyscreen.sh -na -e mkv -o /tmp/out.mkv"
        echo " ./recordmyscreen.sh --audio --extension mkv --preset"
        echo " ./recordmyscreen.sh --no-audio --extension mp4 --output /tmp/out.mp4"
        echo " ./recordmyscreen.sh --audio-microphone --extension mp4 --output /tmp/out.mp4"
        echo
        echo " This script based on ffmpeg. See more: "
        echo " https://www.ffmpeg.org/"
        echo

elif [ "$1" == "" ] && [ "$2" == "" ] && [ "$3" == "" ] && [ "$4" == "" ] && [ "$5" == "" ];
then
  echo "error: show help with './recordmyscreen.sh -h'"

elif [ "$1" == "-na" ] || [ "$1" == "--no-audio" ];
then
	if [ "$2" == "-o" ] && [ "$3" == "" ] ] && [ "$4" == "-e" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$2" == "--output" ] && [ "$3" == "" ] ] && [ "$4" == "--extension" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$4" == "-p" ] && [ "$2" == "-e" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$4" == "--preset" ] && [ "$2" == "--extension" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$2" == "-e" ] && [ "$3" != "" ] &&  [ "$4" == "-o" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac

	elif [ "$2" == "--extension" ] && [ "$3" != "" ] &&  [ "$4" == "--output" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac
  fi

elif [ "$1" == "-a" ] || [ "$1" == "--audio" ];
then
	if [ "$2" == "-o" ] && [ "$3" == "" ] ] && [ "$4" == "-e" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$2" == "--output" ] && [ "$3" == "" ] ] && [ "$4" == "--extension" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$4" == "-p" ] && [ "$2" == "-e" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse  -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$4" == "--preset" ] && [ "$2" == "--extension" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$2" == "-e" ] && [ "$3" != "" ] &&  [ "$4" == "-o" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac

	elif [ "$2" == "--extension" ] && [ "$3" != "" ] &&  [ "$4" == "--output" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v mpeg4 -qscale:v 4.5 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac
  fi

elif [ "$1" == "-amic" ] || [ "$1" == "--audio-microphone" ];
then
	if [ "$2" == "-o" ] && [ "$3" == "" ] ] && [ "$4" == "-e" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$2" == "--output" ] && [ "$3" == "" ] ] && [ "$4" == "--extension" ] && [ "$5" == "" ] ] ;
	then
		echo "error: please set container and output destination"

	elif [ "$4" == "-p" ] && [ "$2" == "-e" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo \
						 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
             -filter_complex amerge -ac 2 -ar 44100 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$4" == "--preset" ] && [ "$2" == "--extension" ] ;
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo \
						 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
             -filter_complex amerge -ac 2 -ar 44100 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 /tmp/out.mp4
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv /tmp/out.mkv
		         ;;
		  *) echo "error: please set container"
		esac

	elif [ "$2" == "-e" ] && [ "$3" != "" ] &&  [ "$4" == "-o" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo \
						 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
             -filter_complex amerge -ac 2 -ar 44100 \
		         -c:v mpeg4 -qscale:v 4 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac

	elif [ "$2" == "--extension" ] && [ "$3" != "" ] &&  [ "$4" == "--output" ] && [ "$5" != "" ];
	then
		case "$3" in
		  "mp4") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo \
						 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
             -filter_complex amerge -ac 2 -ar 44100 \
		         -c:v mpeg4 -qscale:v 4.5 -preset veryfast -format mp4 $5
		         ;;
		  "mkv") ffmpeg \
		         -f x11grab -framerate 30 -video_size 1366x768 -i :0.0 \
             -f pulse -ac 1 -ar 44100 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
		         -c:v libx264 -qscale:v 1 -preset ultrafast -format mkv $5
		         ;;
		esac
  fi
fi

# Sound from default hardware
#-f alsa -ac 1 -ar 44100 -i default \
# Sound in applications
#-f pulse -ac 1 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
# Mic	
#-f pulse -ac 1 -ar 44100 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
# Lossless video
#-c:v libx264 -qp 0 -preset ultrafast $2 \
#1>/dev/null
#   index: 0
#	name: <alsa_output.pci-0000_00_1b.0.analog-stereo.monitor>
#		device.description = "Monitor of Built-in Audio Analog Stereo"
# * index: 1
#	name: <alsa_input.pci-0000_00_1b.0.analog-stereo>
#		device.description = "Built-in Audio Analog Stereo"

