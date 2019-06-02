#!/bin/bash

#Install apache webserver
yum install httpd -y
systemctl start httpd
systemctl enable httpd

#Disable selinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

#set firewall rules
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

firewall-cmd --reload
