#!/bin/bash
printf "Waiting for Network"
while true; do
  wget -q --spider http://google.com
    if [ $? -eq 0 ]; then
        break
    else
        sleep 1
    fi
done
curl -o "/home/pi/run.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/run.py" -L
chmod +x /home/pi/run.py
sudo /home/pi/run.sh
