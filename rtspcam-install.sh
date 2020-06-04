#!/bin/bash
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -t 1 -n 100000 discard 
read -p "clearing buffer" -t 1 -n 10000 discard
echo -ne "\033c"
read -p "type hostname for this device: " hostname
read -p "password for this device: " mypass
sudo sed -i 's/console=tty1/console=tty3 loglevel=3 logo.nologo/' /boot/cmdline.txt
sudo sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" /boot/bootcode.bin
echo '#dtoverlay=vc4-kms-v3d' | sudo tee --append /boot/config.txt
echo 'dtoverlay=w1-gpio' | sudo tee --append /boot/config.txt
sudo sed -i 's/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/' /boot/config.txt
echo 'disable_splash=1' | sudo tee --append /boot/config.txt
echo 'disable_camera_led=1' | sudo tee --append /boot/config.txt
sudo raspi-config nonint do_memory_split 256
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_spi 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_serial 0
sudo raspi-config nonint do_onewire 0
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime
sudo systemctl disable vncserver-x11-serviced.service
sudo curl -o "/lib/systemd/system/v4l2rtspserver.service" "https://github.com/eddwatts/SmS/raw/master/v4l2rtspserver.service?id=$RANDOM" -L
sudo apt-get install cmake liblog4cpp5-dev libv4l-dev git -y
git clone https://github.com/mpromonet/v4l2rtspserver.git && cd v4l2rtspserver/
cmake . && make && sudo make install
sudo systemctl enable v4l2rtspserver
sudo systemctl start v4l2rtspserver
sudo apt-get clean
sudo apt-get autoremove -y
sudo raspi-config nonint do_hostname $hostname
sudo echo -e "raspberry\n$mypass\n$mypass" | passwd
sudo reboot
