#!/bin/bash

docker build -t hello-world /home/vagrant/shared_folder/dockerfiles/
docker run -p 80:80 hello-world