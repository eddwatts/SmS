#!/bin/bash
source /boot/SmS.cfg
IFS="$IFS"$'\r'
printf "Waiting for Network"
while true; do
    LC_ALL=C nmcli -t -f DEVICE,STATE dev | grep -q ":connected$"
    if [ $? -eq 0 ]; then
        break
    else
        sleep 1
    fi
done
curl -o "/home/pi/tempnet.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/tempnet.py" -L
chmod +x /home/pi/tempnet.py


if [[ $mode == *"kiosk"* ]]; then
sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/\"exit_type\":\"Crashed\"/\"exit_type\":\"Normal\"/' /home/pi/.config/chromium/Default/Preferences
chromium-browser --noerrdialogs --incognito --kiosk $url
fi 
if [[ $mode == *"cctv"* ]]; then
echo getting $url
curl -o "/home/pi/cctv.sh" $url -L
chmod +x /home/pi/cctv.sh
sudo /home/pi/cctv.sh stop
sudo /home/pi/cctv.sh repair
fi
