#!/bin/bash

#Install apache webserver
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

#Disable selinux
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

#activate firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld

#set firewall rules
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=22/udp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp

sudo firewall-cmd --reload

#Configure Reverse-Proxy
#yum install install libapache2-mod-proxy-html -y

reboot
