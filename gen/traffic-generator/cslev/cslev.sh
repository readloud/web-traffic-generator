#!/bin/bash
echo "Welcome to web traffic generator!"

sudo ufw status
sudo ufw allow 53/tcp
sudo ufw allow 43/tcp
sudo ufw reload

secs1=300
secs2=3   # Set interval in seconds.

SECONDS=0
SECONDS2=0

while (( SECONDS < secs1 )); do
  sudo ifconfig wlan0 down
  sudo macchanger -r wlan0
  sudo ifconfig wlan0 up

  sleep 2

  ping -c 5 google.com
  
  sleep 2

done

sudo ifconfig wlan0 down
sudo macchanger -p wlan0
sudo ifconfig wlan0 up
