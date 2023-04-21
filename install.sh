#!/bin/bash

sudo sleep 30
sudo apt-get update
sudo apt-get install -y apache2
sudo chmod -R 777 /var/www/html/index.html
sudo echo "<h1>Welcome to Packer AMI Build => $(hostname -f)</h1>" > /var/www/html/index.html