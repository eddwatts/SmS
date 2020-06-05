#!/bin/bash
read -p "clearing buffer" -t 1 -n 10000 discard
echo -ne "\033c"
#read -p "type hostname for this device: " hostname
#read -p "password for this device: " mypass
read -p "remote.it Username: " rituser
read -p "remote.it Password: " ritpass
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
sudo apt-get install -y git remoteit
sudo remoteit signin $rituser $ritpass
sudo remoteit setup $hostname
sudo remoteit add SSL 22 -t SSH
sudo sudo remoteit add "remoteit Admin Panel" 29999 -t 7
#sudo raspi-config nonint do_hostname $hostname
#sudo echo -e "raspberry\n$mypass\n$mypass" | passwd
#sudo reboot
