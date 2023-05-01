#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Instalar MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get install -y mongodb

# Iniciar el servicio de MongoDB
sudo systemctl start mongodb
sudo systemctl status mongodb
sudo systemctl enable mongodb

# Instalar Node.js y npm
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs npm

echo "* NodeJS Versión: "
node -v

echo "* NPM Versión: "
npm -v

# Instalar Nginx
sudo apt-get install -y nginx

# Configurar Nginx para el servidor MEAN
sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default

# Escribir la configuración de Nginx en el archivo de configuración
sudo tee -a /etc/nginx/sites-available/default > /dev/null <<EOT
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    location /api {
        proxy_pass http://127.0.0.1:4200;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOT

# Reiniciar Nginx
sudo systemctl restart nginx

# Crear una nueva aplicación Node.js
sudo mkdir my-mean-app
cd my-mean-app

# Clonar el repositorio de Node.js y MongoDB
sudo git clone https://github.com/UNIR-DevOps/default_nodejs_mongodb_server.git
cd default_nodejs_mongodb_server

# Instalar 
sudo npm install -g

# Ejecutar la aplicación backend
sudo node index.js &

# Comprobar que la aplicación se ha iniciado correctamente
sleep 10
if ps aux | grep node | grep 3000; then
  echo "La aplicación se ha iniciado correctamente."
  exit 0
else
  echo "No se pudo iniciar la aplicación."
  exit 1
fi