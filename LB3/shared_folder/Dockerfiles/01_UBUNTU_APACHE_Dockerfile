#Configure base image
FROM ubuntu:16.04

#Install software
RUN apt-get update
RUN apt-get -q -y install apache2

#Configure apache service
##No configuration added just yet

#Network configuration
EXPOSE 80
CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

#Share folder with /var/www/html/
