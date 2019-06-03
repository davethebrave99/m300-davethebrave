#!/bin/bash

#Install mariadb
sudo yum install mariadb-server mariadb -y

sudo systemctl start mariadb
sudo systemctl enable mariadb

#harden mysql

#Disable selinux
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

#activate firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld

#set firewall rules
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=22/udp

sudo firewall-cmd --reload

reboot