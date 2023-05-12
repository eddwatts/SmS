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
curl -o "/home/pi/update/run.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/run.sh?id=$RANDOM" -L
chmod +x /home/pi/update/run.sh
/home/pi/update/run.sh
