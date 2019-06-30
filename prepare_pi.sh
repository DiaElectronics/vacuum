#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt install -y redis-server libssl-dev libsdl-image1.2-dev libevent-dev libsdl1.2-dev

sudo echo "@xset s off" >> /etc/xdg/lxsession/LXDE-pi/autostart
sudo echo "@xset -dpms" >> /etc/xdg/lxsession/LXDE-pi/autostart
sudo echo "@xset s noblank" >> /etc/xdg/lxsession/LXDE-pi/autostart
sudo echo "@/home/pi/run.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart

sudo echo "@xset s off" >> /home/pi/.config/lxsession/LXDE-pi/autostart
sudo echo "@xset -dpms" >> /home/pi/.config/lxsession/LXDE-pi/autostart
sudo echo "@xset s noblank" >> /home/pi/.config/lxsession/LXDE-pi/autostart
sudo echo "@/home/pi/run.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart

sudo echo "save 30 1" >> /etc/redis/redis.conf
sudo echo "appendonly yes" >> /etc/redis/redis.conf

sudo echo "hdmi_group=2" >> /boot/config.txt
sudo echo "hdmi_mode=14" >> /boot/config.txt


echo "cd /home/pi/vacuum" >> /home/pi/run.sh
echo "./update.sh &" >> /home/pi/run.sh
echo "sleep 1" >> /home/pi/run.sh
echo "./firmware.exe" >> /home/pi/run.sh

cd /home/pi
read -p "Enter Card Code : " card_code
echo "$card_code" >> id.txt
chmod 777 /home/pi/run.sh
