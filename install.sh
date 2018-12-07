#!/bin/bash 
sudo sed -i 's/console=tty1/console=tty3 loglevel=3 logo.nologo/' /boot/cmdline.txt
sudo sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" /boot/bootcode.bin
echo '#dtoverlay=vc4-kms-v3d' | sudo tee --append /boot/config.txt
echo 'dtoverlay=w1-gpio' | sudo tee --append /boot/config.txt
echo 'dtparam=i2c_arm=on' | sudo tee --append /boot/config.txt
echo 'dtparam=spi=on' | sudo tee --append /boot/config.txt
echo 'hdmi_force_hotplug=1' | sudo tee --append /boot/config.txt
echo 'disable_splash=1' | sudo tee --append /boot/config.txt
sudo raspi-config nonint do_memory_split 256
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_spi 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_serial 0
sudo raspi-config nonint do_onewire 0
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime
sudo systemctl disable vncserver-x11-serviced.service
sudo curl -o "/usr/share/plymouth/themes/pix/splash.png" "https://raw.githubusercontent.com/eddwatts/SmS/master//pi.png" -L
sudo curl -o "/usr/share/rpd-wallpaper/road.jpg" "https://raw.githubusercontent.com/eddwatts/SmS/master/desktop.jpg" -L
curl -o "/home/pi/update.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/update.sh" -L
chmod +x /home/pi/update.sh
echo '@xset s off' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@xset -dpms' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@xset s noblank' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@unclutter -idle 0 -root' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@/home/pi/update.sh' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/@xscreensaver/#@xscreensaver/' /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/@lxpanel/#@lxpanel/' /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/point-rpi/#point-rpi/' /etc/xdg/lxsession/LXDE-pi/autostart
crontab -l > mycron
echo "30 07 * * 1-5 sudo reboot" >> mycron
echo "35 19 * * 1-5 /opt/vc/bin/tvservice -o" >> mycron
echo "*/5 * * * * sudo /home/pi/tempnet.py" >> mycron
echo "*/1 7-19 * * * sudo /home/pi/cctv.sh repair" >> mycron
crontab mycron
rm mycron
sudo apt-get install network-manager unclutter screen omxplayer i2c-tools -y
sudo apt-get purge piwiz idle3 java-common geany -y
sudo apt-get clean
sudo apt-get autoremove -y
