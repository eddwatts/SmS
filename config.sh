echo "768 or 1080: "
read res
echo "type hostname for this device: "
read hostname
echo "set password for this device: "
read mypass
IFS="$IFS"$'\r'
if [[ $res == *"768"* ]]; then
echo 'hdmi_group=2' | sudo tee --append /boot/config.txt
echo 'hdmi_mode=16' | sudo tee --append /boot/config.txt
fi
if [[ $res == *"1080"* ]]; then
echo 'hdmi_group=1' | sudo tee --append /boot/config.txt
echo 'hdmi_mode=31' | sudo tee --append /boot/config.txt
fi
sudo raspi-config nonint do_hostname $hostname
sudo echo -e "raspberry\n$mypass\n$mypass" | passwd
