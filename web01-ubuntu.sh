#!/bin/bash

#Install apache webserver
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2


#activate firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld

#set firewall rules
sudo ufw allow 22
sudo ufw allow proto tcp from any to any port 80,443
ufw commit

#Configure Reverse-Proxy
#yum install install libapache2-mod-proxy-html -y


