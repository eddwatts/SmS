printf "Waiting for Network"
while true; do
    LC_ALL=C nmcli -t -f DEVICE,STATE dev | grep -q ":connected$"
    if [ $? -eq 0 ]; then
        break
    else
        sleep 1
    fi
done
curl -o "/home/pi/run.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/run.py" -L
chmod +x /home/pi/run.py
sudo ./run.sh
