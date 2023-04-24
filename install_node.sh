#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Instalar MongoDB
sudo apt-get install -y mongodb

# Iniciar el servicio de MongoDB
sudo systemctl start mongodb
sudo systemctl enable mongodb

# Instalar Node.js y npm
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Instalar Express.js globalmente
sudo npm install -g express

# Instalar Angular globalmente
sudo npm install -g @angular/cli

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
        proxy_pass http://127.0.0.1:4000;
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
mkdir my-mean-app
cd my-mean-app
npm init -y

# Instalar Express.js y Mongoose para el backend
npm install express mongoose

# Crear archivo helloworld.js
touch helloworld.js

# Escribir código en helloworld.js
echo "const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello World LUIS OLARTE!');
});

app.listen(PORT, () => {
  console.log('LUIS OLARTE :) Server is running on port ' + PORT);
});" > helloworld.js

# Instalar Angular para el frontend
ng new client

# Ejecutar la aplicación backend
node helloworld.js &

# Ejecutar la aplicación frontend
cd client
ng serve &
