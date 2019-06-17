#!/bin/bash

#Change vagrant password
sudo echo "barth" | passwd --stdin vagrant

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

#set firewall rules for http
sudo firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="80" accept'

#set firewall rules for https
sudo firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="443" accept'

#reload firewalld configuration
sudo firewall-cmd --reload

#reboot to make selinux changes active
sudo reboot