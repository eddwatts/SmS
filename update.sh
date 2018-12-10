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
curl -o "/home/pi/run.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/run.sh" -L
chmod +x /home/pi/run.sh
/home/pi/run.sh
