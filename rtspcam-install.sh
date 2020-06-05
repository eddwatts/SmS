#!/bin/bash
read -p "clearing buffer" -t 1 -n 10000 discard
echo -ne "\033c"
read -p "type hostname for this device: " hostname
read -p "changeip.com Domain: " mydom
read -p "changeip.com Username: " mydomuser
read -p "changeip.com Password: " mydompass
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
sudo mkdir -p /etc/motioneye && mkdir -p /var/lib/motioneye && mkdir /home/pi/noip
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq ddclient < /dev/null > /dev/null
sudo apt-get install -y ffmpeg git libmariadb3 libpq5 libmicrohttpd12 tornado jinja2 jinja2 libio-socket-ssl-perl remoteit 
sudo rm /etc/ddclient.conf
echo '  #tell ddclient how to get your ip address' | sudo tee --append /etc/ddclient.conf
echo '  use=web, web=ip.changeip.com' | sudo tee --append /etc/ddclient.conf
echo '  #provide server and login details' | sudo tee --append /etc/ddclient.conf
echo '  protocol=changeip' | sudo tee --append /etc/ddclient.conf
echo '  ssl=yes' | sudo tee --append /etc/ddclient/ddclient.conf
echo '  server=nic.changeip.com/nic/update' | sudo tee --append /etc/ddclient.conf
echo '  login='$mydomuser | sudo tee --append /etc/ddclient.conf
echo '  password='$mydompass | sudo tee --append /etc/ddclient.conf
echo '  #specify the domain to update' | sudo tee --append /etc/ddclient.conf
echo '  '$mydom | sudo tee --append /etc/ddclient.conf
sudo sed -i -e 's/run_daemon="false"/run_daemon="true"/' /etc/default/ddclient
sudo ddclient -debug -noquiet
sudo service ddclient start
sudo apt-get install -y apache2 python-certbot-apache
sudo certbot --apache
certbot certonly --standalone -d $mydom -d www.$mydom
sudo pip install motioneye
sudo cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
sudo cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
sudo systemctl daemon-reload
sudo systemctl enable motioneye
sudo systemctl start motioneye
sudo a2enmod proxy && sudo a2enmod proxy_http && sudo a2enmod proxy_balancer && sudo a2enmod lbmethod_byrequests
echo 'Listen 443' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '<IfModule mod_ssl.c>' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo 'ServerName thelazys.hopto.org' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '    SSLEngine on' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo 'SSLCertificateFile    /etc/letsencrypt/live/'$mydom'/cert.pem' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo 'SSLCertificateKeyFile /etc/letsencrypt/live/'$mydom'/privkey.pem' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo 'SSLCertificateChainFile /etc/letsencrypt/live/'$mydom'/fullchain.pem' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
#echo '    SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
#echo '    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '  <VirtualHost _default_:8443>' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '  ProxyPreserveHost On' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '  ProxyPass "/"  "http://127.0.0.1:8765/"' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '  ProxyPassReverse "/"  "http://127.0.0.1:8765/"' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '  </VirtualHost>' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
echo '</IfModule>' | sudo tee --append /etc/apache2/sites-available/motioneye.conf
sudo a2ensite motioneye.conf
sudo systemctl restart apache2
sudo apt install -y remoteit
sudo raspi-config nonint do_hostname $hostname
sudo echo -e "raspberry\n$mypass\n$mypass" | passwd
