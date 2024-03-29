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
if [[ $mode == *"cctv"* ]]; then
# Camera Feeds & Positions 
#cam1="screen -dmS cam1 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,0,512,384\" rtsp://10.1.8.253:7447/5b85280cb07d32af7d9d5122_2 --crop 160,0,640,360 --live -n -1'"; 
#cam2="screen -dmS cam2 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,0,768,192\" rtsp://10.1.8.253:7447/5b5594b1429163364af61e46_2 --crop 0,0,480,360 --live -n -1'"; 
#cam3="screen -dmS cam3 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"768,0,1024,192\" rtsp://10.1.8.253:7447/58d3d58ee4b03b4107ccf8b4_2 --crop 0,0,480,360 --live -n -1'"; 
#cam4="screen -dmS cam4 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,192,768,384\" rtsp://10.1.8.253:7447/55afbd53e68320b007c89f05_2 --crop 0,0,480,360 --live -n -1'"; 
#cam5="screen -dmS cam5 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"768,192,1024,384\" rtsp://10.1.8.253:7447/58d3d92be4b0f5ccd5ca0149_2 --crop 0,0,480,360 --live -n -1'"; 
#cam6="screen -dmS cam6 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,384,512,768\" rtsp://10.1.8.253:7447/58d3d372e4b03b4107ccf2b3_2 --crop 0,0,480,360 --live -n -1'"; 
#cam7="screen -dmS cam7 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,384,1024,768\" rtsp://10.1.8.253:7447/5a7c0d87e4b0d6cdfb8e5d48_2 --crop 160,0,640,360 --live -n -1'"; 

#cam1="screen -dmS cam1 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,0,512,384\" rtsp://10.1.8.253:7447/5b85280cb07d32af7d9d5122_2 --crop 160,0,640,360 --live -n -1'"; 
#cam2="screen -dmS cam2 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,0,768,192\" rtsp://10.1.0.25:7447/55bb325be68320b007c92622_2 --crop 0,0,480,360 --live -n -1'"; 
#cam3="screen -dmS cam3 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"768,0,1024,192\" rtsp://10.1.0.25:7447/55bb3559e68320b007c92657_2 --crop 0,0,480,360 --live -n -1'"; 
#cam4="screen -dmS cam4 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,192,768,384\" rtsp://10.1.0.25:7447/5f5a36a14cabb278b6996663_2 --crop 0,0,480,360 --live -n -1'"; 
#cam5="screen -dmS cam5 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"768,192,1024,384\" rtsp://10.1.0.25:7447/55ba4a45e68320b007c91741_2 --crop 0,0,480,360 --live -n -1'"; 
#cam6="screen -dmS cam6 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,384,512,768\" rtsp://10.1.8.253:7447/58d3d372e4b03b4107ccf2b3_2 --crop 0,0,480,360 --live -n -1'"; 
#cam7="screen -dmS cam7 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"512,384,1024,768\" rtsp://10.1.8.253:7447/5a7c0d87e4b0d6cdfb8e5d48_2 --crop 160,0,640,360 --live -n -1'"; 
#cam1="screen -dmS cam1 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,0,960,540\" rtsp://10.1.8.252:7447/J00m7DXmIAPYZVu3 --live -n -1'";
cam1="screen -dmS cam1 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,0,960,540\" rtsp://10.1.8.252:7447/IbZfbJWLDOR5Pywt --live -n -1'";
cam2="screen -dmS cam2 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960,0,1440,270\" rtsp://10.1.8.252:7447/hqeg2xY06JWtFoEr --live -n -1'";
cam3="screen -dmS cam3 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"1440,0,1920,270\" rtsp://10.1.8.252:7447/KKC1v1G2EpyIhJsc --live -n -1'";
#cam4="screen -dmS cam4 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960,270,1440,540\" rtsp://10.1.8.252:7447/mFcWnmhDe7Trdthf --live -n -1'";
cam4="screen -dmS cam4 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960,270,1440,540\" rtsp://10.1.8.252:7447/RqDYBjSy2z5RHSFM --live -n -1'";
cam5="screen -dmS cam5 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"1440,270,1920,540\" rtsp://10.1.8.252:7447/Rblnw8o0Cn2hXaZl --live -n -1'";
cam6="screen -dmS cam6 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"0,540,960,1080\" rtsp://10.1.8.252:7447/dbU6YZHyh9cEtbf7 --live -n -1'";
cam7="screen -dmS cam7 sh -c 'omxplayer --avdict rtsp_transport:tcp --win \"960,540,1920,1080\" rtsp://10.1.8.252:7447/e4cnIbK8lb0WmpdV --live -n -1'";

# Camera Feed Names 
# (variable names from above, separated by a space) 
camera_feeds=(cam1 cam2 cam3 cam4 cam5 cam6 cam7)

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
