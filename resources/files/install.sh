#!/bin/bash

echo -e "\n\033[0;33m+--------------------------- Inicio script -------------------------+\033[0m\n"
sudo chmod 777 /home/ubuntu/server.js
sudo chmod 777 /home/ubuntu/default
sudo rm -rf fvar/lib/apt/lists/*
sudo apt-get update
curl -sl https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install build-essential
sudo npm install pm2 -g
sudo apt-get install -y nginx 
sudo systemctl enable nginx 
sudo systemctl start nginx
sudo cp /home/ubuntu/default /etc/nginx/sites-available/default
sudo cp /home/ubuntu/server.js /var/www/html/
sudo chmod 777 /var/www/html/server.js
sudo cp /var/www/html/server.js /etc/nginx/sites-available/
sudo nginx -t && sudo systemctl restart nginx
sudo pm2 start /etc/nginx/sites-available/server.js && sudo pm2 startup && sudo pm2 save --force 
sleep 30
echo -e "\n\033[0;33m+--------------------------- Inicio prueba -------------------------+\033[0m\n"
sudo curl http://localhost

# Verifica si la petición HTTP tuvo éxito (status code 200) para saber si el servicio está arriba.
if [ $? -eq 0 ]; then
    echo -e "\n\033[0;32m***** El servicio está arriba y funcionando correctamente. *****\033[0m\n"
else
    echo -e "\n\033[0;31m***** El servicio no está funcionando correctamente. *****\033[0m\n"
fi
echo -e "\n\033[0;33m+--------------------------- Fin script -------------------------+\033[0m\n"
