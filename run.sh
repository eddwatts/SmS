#!/bin/bash
source /boot/SmS.cfg
IFS="$IFS"$'\r'
curl -o "/home/pi/update.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/update.sh?id=$RANDOM" -L
chmod +x /home/pi/update.sh
curl -o "/home/pi/tempnet.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/tempnet.py?id=$RANDOM" -L
chmod +x /home/pi/tempnet.py
if [[ $mode == *"kiosk"* ]]; then
sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/\"exit_type\":\"Crashed\"/\"exit_type\":\"Normal\"/' /home/pi/.config/chromium/Default/Preferences
chromium-browser --check-for-update-interval=31536000 --noerrdialogs --incognito --kiosk $url?random=$RANDOM
fi 
if [[ $mode == *"cctv"* ]]; then
echo "getting file:" $url?random=$RANDOM
curl -o "/home/pi/cctv.sh" $url?random=$RANDOM -L
chmod +x /home/pi/cctv.sh
sudo /home/pi/cctv.sh stop
sudo /home/pi/cctv.sh repair
fi
if [[ $mode == *"NewView"* ]]; then
sudo systemctl stop displaycameras.service
curl -o "/etc/displaycameras/layout.conf.default" $url?random=$RANDOM -L
sudo systemctl start displaycameras.service
fi
