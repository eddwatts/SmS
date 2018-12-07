#!/bin/bash 
### BEGIN INIT INFO 
# Provides: omxplayer 
# Required-Start: 
# Required-Stop: 
# Default-Start: 2 3 4 5 
# Default-Stop: 0 1 6 
# Short-Description: Displays camera feeds for monitoring 
# Description: 
### END INIT INFO
source /boot/SmS.cfg
if test "$mode" = 'cctv"'; then
# Camera Feeds & Positions 
top_left="screen -dmS top_left sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0 0 960 540\" rtsp://10.1.8.253:7447/5b85280cb07d32af7d9d5122_2 --live -n -1'"; 
top_right="screen -dmS top_right sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960 0 1920 540\" rtsp://10.1.8.253:7447/58d3d372e4b03b4107ccf2b3_2 --live -n -1'"; 
bottom_left="screen -dmS bottom_left sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0 540 960 1080\" rtsp://10.1.8.253:7447/58d3d58ee4b03b4107ccf8b4_2 --live -n -1'"; 
bottom_right="screen -dmS bottom_right sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960 540 1920 1080\" rtsp://10.1.8.253:7447/5a7c0d87e4b0d6cdfb8e5d48_2 --live -n -1'";






# Camera Feed Names 
# (variable names from above, separated by a space) 
camera_feeds=(top_left top_right bottom_left bottom_right)

#---- There should be no need to edit anything below this line ----

# Start displaying camera feeds
case "$1" in
start)
now="$(date)"
for i in "${camera_feeds[@]}"
do
eval eval '$'$i
done
echo ""$now" - Camera Display Started"
;;

# Stop displaying camera feeds
stop)
now="$(date)"
sudo killall omxplayer.bin
echo ""$now" - Camera Display Ended"
;;

# Restart any camera feeds that have died
repair)
now="$(date)"
for i in "${camera_feeds[@]}"
do
if !(sudo screen -list | grep -q $i)
then
eval eval '$'$i
echo ""$now" -    $i is now running"
fi
done
;;

*)
echo "Usage: /etc/init.d/displaycameras {start|stop|repair}"
exit 1

;;
esac
fi
