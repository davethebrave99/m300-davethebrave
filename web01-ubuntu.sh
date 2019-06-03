#!/bin/bash

#update
sudo apt-get update -y
sudo apt-get install apache2-bin

#Install apache webserver
sudo apt-get install apache2 -y
sudo service apache2 start 
sudo service apache2 enable


#activate firewall
sudo apt-get install ufw -y
yes | sudo ufw enable

#set firewall rules
sudo ufw deny out to any
sudo ufw allow 22
sudo ufw allow 80/tcp
sudo ufw allow 80/udp
sudo ufw allow 443/tcp
sudo ufw allow 443/udp

#reload firewall
yes | sudo ufw enable

#Configure Reverse-Proxy
sudo apt-get install libapache2-mod-proxy-html -y
sudo apt-get install libxml2-dev -y

sudo a2enmod proxy
sudo a2enmod proxy_html
sudo a2enmod proxy_http

sudo service apache2 restart

# append to /etc/apache2/apache2.conf
echo "" >> /etc/apache2/apache2.conf
echo "web01ubuntu localhost" >> /etc/apache2/apache2.conf

# /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "# Allgemeine Proxy Einstellungen" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "ProxyRequests Off" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "<Proxy *>" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "  Order deny,allow" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "   Allow from all" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "</Proxy>" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "# Weiterleitungen master" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "ProxyPass /master http://master" >> /etc/apache2/sites-enabled/001-reverseproxy.conf
echo "ProxyPassReverse /master http://master" >> /etc/apache2/sites-enabled/001-reverseproxy.conf

#restart apache2 service
sudo service apache2 restart
