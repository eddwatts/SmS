#!/bin/bash
IFS="$IFS"$'\r'
#curl -o "/home/pi/update/tempnet.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/tempnet.py?id=$RANDOM" -L
#chmod +x /home/pi/update/tempnet.py
read MAC </sys/class/net/eth0/address
MAC="${MAC//:/}"
MAC=${MAC^^}
#echo "getting file:" $url"?MAC="$MAC"&random="$RANDOM
#curl -o "/home/pi/cctv.sh" $url?random=$RANDOM -L
wall -n "getting File: https://staffdashboard.stmichaelsschool.co.uk/CCTV/screens.php?MAC1="$MAC
curl -o "/home/pi/update/cctv1.sh" https://staffdashboard.stmichaelsschool.co.uk/CCTV/screens.php?MAC1=$MAC -L
sed -i -e 's/\r$//' /home/pi/update/cctv1.sh
chmod +x /home/pi/update/cctv1.sh
/home/pi/update/cctv1.sh stop
/home/pi/update/cctv1.sh repair
