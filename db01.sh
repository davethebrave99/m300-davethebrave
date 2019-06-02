#!/bin/bash

#Install wget in order to download mysql package
yum install wget -y

#Download mysql repository & update
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update

#
yum install mysql-server -y
systemctl start mysqld
systemctl enable mysqld

#harden mysql