#!/bin/bash

#Install apache webserver
yum install httpd -y
systemctl start httpd
systemctl enable httpd

#Disable selinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

#set firewall rules for http
firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="80" accept'

#set firewall rules for https
firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="443" accept'

#reload firewalld configuration
firewall-cmd --reload

#reboot to make selinux changes active
reboot