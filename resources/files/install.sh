#!/bin/bash

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- Inicio script -------------------------+\033[0m\n"

# Cambia los permisos del archivo "server.js" para que sea accesible para todos los usuarios.
sudo chmod 777 /home/ubuntu/server.js

# Cambia los permisos del archivo "default" para que sea accesible para todos los usuarios.
sudo chmod 777 /home/ubuntu/default

# Borra el contenido del directorio "/var/lib/apt/lists/", que contiene los paquetes descargados previamente por el gestor de paquetes "apt-get".
sudo rm -rf /var/lib/apt/lists/*

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- apt-get update -------------------------+\033[0m\n"

# Actualiza la lista de paquetes disponibles en los repositorios configurados en el sistema.
sudo apt-get update

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- install nodejs -------------------------+\033[0m\n"

# Descarga el script de configuración de Node.js desde NodeSource y lo ejecuta con permisos de superusuario.
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

# Instala Node.js y npm desde el repositorio agregado anteriormente.
sudo apt-get install -y nodejs

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- install build-essential -------------------------+\033[0m\n"

# Instala el paquete "build-essential", que contiene herramientas de compilación necesarias para compilar software a partir del código fuente.
sudo apt install build-essential

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- install PM2 -------------------------+\033[0m\n"

# Instala pm2 globalmente utilizando npm.
sudo npm install pm2 -g

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- install nginx -------------------------+\033[0m\n"

# Instala Nginx, un servidor web y proxy inverso, utilizando "apt-get".
sudo apt-get install -y nginx

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- enable and start nginx -------------------------+\033[0m\n"

# Habilita Nginx para que se inicie automáticamente al arrancar el sistema.
sudo systemctl enable nginx

# Inicia el servidor web Nginx.
sudo systemctl start nginx

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- enable and start  PM2 -------------------------+\033[0m\n"

# Habilita el servicio de PM2
sudo systemctl enable pm2

# Inicia el servicio de PM2
sudo systemctl start pm2

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- se copia archivos en nginx -------------------------+\033[0m\n"

# Copia el archivo de configuración "default" a la carpeta de configuración de Nginx.
sudo cp /home/ubuntu/default /etc/nginx/sites-available/default

# Copia el archivo "server.js" a la carpeta de archivos de contenido web de Nginx.
sudo cp /home/ubuntu/server.js /var/www/html/

# Cambia los permisos del archivo "server.js" en la carpeta de archivos de contenido web de Nginx para que sea accesible para todos los usuarios.
sudo chmod 777 /var/www/html/server.js

# Copia el archivo "server.js" a la carpeta de configuración de Nginx.
sudo cp /var/www/html/server.js /etc/nginx/sites-available/

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- reiniciando nginx -------------------------+\033[0m\n"

# Verifica la sintaxis de la configuración de Nginx y reinicia Nginx si la sintaxis es válida.
sudo nginx -t && sudo systemctl restart nginx

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- reiniciando PM2 -------------------------+\033[0m\n"

# Inicia la aplicación "server.js" con pm2 y configura pm2 para que se ejecute automáticamente al arrancar el sistema.
sudo pm2 start /etc/nginx/sites-available/server.js && sudo pm2 startup && sudo pm2 save --force 

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- Inicio prueba -------------------------+\033[0m\n"

# Espera 20 segundos para que la aplicación "server.js" se inicie completamente.
sleep 20

# Hace una petición HTTP a "http://localhost" para verificar si el servidor está funcionando correctamente.
sudo curl http://localhost

# Verifica si la petición HTTP tuvo éxito (status code 200) para saber si el servicio está arriba.
if [ $? -eq 0 ]; then
    echo -e "\n\033[0;32m***** El servicio está arriba y funcionando correctamente. *****\033[0m\n"
else
    echo -e "\n\033[0;31m***** El servicio no está funcionando correctamente. *****\033[0m\n"
fi

# Bandera bash
echo -e "\n\033[0;33m+--------------------------- Fin script -------------------------+\033[0m\n"