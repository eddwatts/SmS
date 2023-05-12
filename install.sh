#!/bin/bash
source /boot/SmS.cfg
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
read -p "768,1080,1366: " res
read -p "type hostname for this device: " hostname
read -p "password for this device: " mypass
IFS="$IFS"$'\r'
sudo sed -i 's/console=tty1/console=tty3 loglevel=3 logo.nologo/' /boot/cmdline.txt
sudo sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" /boot/bootcode.bin
echo '#dtoverlay=vc4-kms-v3d' | sudo tee --append /boot/config.txt
echo 'dtoverlay=w1-gpio' | sudo tee --append /boot/config.txt
#echo 'dtparam=i2c_arm=on' | sudo tee --append /boot/config.txt
#echo 'dtparam=spi=on' | sudo tee --append /boot/config.txt
#echo 'hdmi_force_hotplug=1' | sudo tee --append /boot/config.txt
sudo sed -i 's/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/' /boot/config.txt
echo 'disable_splash=1' | sudo tee --append /boot/config.txt
sudo raspi-config nonint do_memory_split 256
sudo raspi-config nonint do_boot_wait 0
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_spi 0
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_serial 0
sudo raspi-config nonint do_onewire 0
if [[ $mode == *"cctv"* ]]; then
sudo raspi-config nonint do_boot_behaviour B2
curl -o "/home/pi/cctv.sh" $url?random=$RANDOM -L
chmod +x /home/pi/cctv.sh
fi
if [[ $mode == *"NewView"* ]]; then
sudo mkdir /etc/displaycameras
sudo curl -o "/usr/bin/displaycameras" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/displaycameras" -L
sudo curl -o "/etc/systemd/system/displaycameras.service" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/displaycameras.service" -L
sudo curl -o "/etc/displaycameras/layout.conf.default" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/layout.conf.default" -L
sudo curl -o "/etc/displaycameras/displaycameras.conf" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/displaycameras.conf" -L
sudo curl -o "/usr/bin/omxplayer_dbuscontrol" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/omxplayer_dbuscontrol" -L
sudo curl -o "/usr/bin/rotatedisplays" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/rotatedisplays" -L
sudo curl -o "/usr/bin/black.png" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/black.png" -L
sudo curl -o "/etc/cron.d/repaircameras/repaircameras.cron" "https://raw.githubusercontent.com/Anonymousdog/displaycameras/master/repaircameras.cron" -L
curl -o "/etc/displaycameras/layout.conf.default" $url?random=$RANDOM -L
sudo chown root:root /usr/bin/displaycameras
sudo chmod 0755 /usr/bin/displaycameras
sudo chown root:root /etc/systemd/system/displaycameras.service
sudo chmod 0644 /etc/systemd/system/displaycameras.service
sudo chown root:root /etc/displaycameras/layout.conf.default
sudo chmod 0644 /etc/displaycameras/layout.conf.default
sudo chown root:root /etc/displaycameras/displaycameras.conf
sudo chmod 0644 /etc/displaycameras/displaycameras.conf
sudo chown root:root /usr/bin/omxplayer_dbuscontrol
sudo chmod 0755 /usr/bin/omxplayer_dbuscontrol
sudo chown root:root /usr/bin/rotatedisplays
sudo chmod 0755 /usr/bin/rotatedisplays
sudo chown root:root /usr/bin/black.png
sudo chown root:root /etc/cron.d/repaircameras
sudo chmod 0755 /etc/cron.d/repaircameras
systemctl restart cron
systemctl daemon-reload
systemctl enable displaycameras
sudo raspi-config nonint do_boot_behaviour B2
fi
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime
sudo systemctl disable vncserver-x11-serviced.service
sudo curl -o "/usr/share/plymouth/themes/pix/splash.png" "https://raw.githubusercontent.com/eddwatts/SmS/master//pi.png?id=$RANDOM" -L
sudo curl -o "/usr/share/rpd-wallpaper/road.jpg" "https://raw.githubusercontent.com/eddwatts/SmS/master/desktop.jpg?id=$RANDOM" -L
sudo curl -o "/usr/share/rpd-wallpaper/temple.jpg" "https://raw.githubusercontent.com/eddwatts/SmS/master/desktop.jpg?id=$RANDOM" -L
curl -o "/home/pi/button_shutdown.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/button_shutdown.py?id=$RANDOM" -L
chmod +x /home/pi/button_shutdown.py
curl -o "/home/pi/blink_ip.py" "https://raw.githubusercontent.com/Matthias-Wandel/pi_blink_ip/master/blink_ip.py?id=$RANDOM" -L
chmod +x /home/pi/blink_ip.py
sudo /home/pi/blink_ip.py install
curl -o "/home/pi/tvoff.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/tvoff.py?id=$RANDOM" -L
chmod +x /home/pi/tvoff.py
curl -o "/home/pi/tvon.py" "https://raw.githubusercontent.com/eddwatts/SmS/master/tvon.py?id=$RANDOM" -L
chmod +x /home/pi/tvon.py
curl -o "/home/pi/tvoff.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/tvoff.sh?id=$RANDOM" -L
chmod +x /home/pi/tvoff.sh
curl -o "/home/pi/tvon.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/tvon.sh?id=$RANDOM" -L
chmod +x /home/pi/tvon.sh
sudo sed -i '0,/^[ \t]*exit[ \t]\+0/s//\/home\/pi\/button_shutdown.py \&\n&/' /etc/rc.local
sudo sed -i '0,/^[ \t]*exit[ \t]\+0/s//\/home\/pi\/update1.sh \&\n&/' /etc/rc.local
curl -o "/home/pi/update1.sh" "https://raw.githubusercontent.com/eddwatts/SmS/master/update1.sh?id=$RANDOM" -L
chmod +x /home/pi/update1.sh
#curl -o "/home/pi/cctv.sh" $url?random=$RANDOM -L
#chmod +x /home/pi/cctv.sh
sudo touch /etc/chromium-browser/customizations/01-disable-update-check;echo CHROMIUM_FLAGS=\"\$\{CHROMIUM_FLAGS\} --check-for-update-interval=31536000\" | sudo tee /etc/chromium-browser/customizations/01-disable-update-check
echo '@xset s off' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@xset -dpms' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@xset s noblank' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@unclutter -idle 0 -root' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
echo '@/home/pi/update1.sh' | sudo tee --append /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/@xscreensaver/#@xscreensaver/' /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/@lxpanel/#@lxpanel/' /etc/xdg/lxsession/LXDE-pi/autostart
sudo sed -i 's/point-rpi/#point-rpi/' /etc/xdg/lxsession/LXDE-pi/autostart
crontab -l >> mycron
echo "#* 6-19 * * * wkhtmltoimage --javascript-delay 10000 --height 1080 --width 1920 --quality 100 https://dakboard.com/screen/uuid/5d975b6f-108291-b306-75f61e0ddff0 /home/pi/Schoolinternet/staffboard/SMS-SB.jpg" >> mycron
echo "28 06 * * * sudo reboot" >> mycron
echo "00 21 * * * /home/pi/tvoff.py" >> mycron
echo "0 21 * * * echo 'standby 0' | cec-client -s -d 1" >> mycron
echo "0 21 * * * vcgencmd display_power 0" >> mycron
echo "25 6 * * * echo 'on 0' | cec-client -s -d 1" >> mycron
echo "25 6 * * * /home/pi/tvon.py" >> mycron
echo "25 6 * * * vcgencmd display_power 1" >> mycron
crontab mycron
rm mycron
sudo apt-get update
sudo apt-get install unclutter screen omxplayer fbi i2c-tools cec-utils wkhtmltopdf -y
sudo apt-get purge piwiz idle3 java-common geany -y
sudo apt-get clean
sudo apt-get autoremove -y
IFS="$IFS"$'\r'
if [[ $res == *"768"* ]]; then
sudo sed -i 's/#hdmi_group=1/hdmi_group=2/' /boot/config.txt
sudo sed -i 's/#hdmi_mode=1/hdmi_mode=16/' /boot/config.txt
sudo sed -i 's/#disable_overscan=1/disable_overscan=1/' /boot/config.txt
#echo 'hdmi_group=2' | sudo tee --append /boot/config.txt
#echo 'hdmi_mode=16' | sudo tee --append /boot/config.txt
#echo 'disable_overscan=1' | sudo tee --append /boot/config.txt
fi
if [[ $res == *"1080"* ]]; then
sudo sed -i 's/#hdmi_group=1/hdmi_group=1/' /boot/config.txt
sudo sed -i 's/#hdmi_mode=1/hdmi_mode=31/' /boot/config.txt
sudo sed -i 's/#disable_overscan=1/disable_overscan=1/' /boot/config.txt
#echo 'hdmi_group=2' | sudo tee --append /boot/config.txt
#echo 'hdmi_mode=82' | sudo tee --append /boot/config.txt
#echo 'disable_overscan=1' | sudo tee --append /boot/config.txt
fi
if [[ $res == *"1366"* ]]; then
sudo sed -i 's/#hdmi_group=1/hdmi_group=2/' /boot/config.txt
sudo sed -i 's/#hdmi_mode=1/hdmi_mode=81/' /boot/config.txt
sudo sed -i 's/#disable_overscan=1/disable_overscan=1/' /boot/config.txt
#echo 'hdmi_group=2' | sudo tee --append /boot/config.txt
#echo 'hdmi_mode=81' | sudo tee --append /boot/config.txt
#echo 'disable_overscan=1' | sudo tee --append /boot/config.txt
fi
mkdir /home/pi/update
echo 'tmpfs /home/pi/update tmpfs nodev,nosuid,size=100M 0 0' | sudo tee --append /etc/fstab
sudo mount -a
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt update
sudo rm /var/log/*.log
sudo rm /var/log/lastlog
sudo rm /var/log/messages
sudo rm /var/log/syslog
sudo rm /var/log/syslog.1
sudo sed -i -e "s/ZL2R=false/ZL2R=true/" /etc/log2ram.conf
sudo apt install log2ram
sudo raspi-config nonint do_hostname $hostname
sudo echo -e "raspberry\n$mypass\n$mypass" | passwd

sudo reboot
