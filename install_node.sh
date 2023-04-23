#!/bin/bash

curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
nano nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
sudo apt install build-essential

sudo chmod -R 777 /var/www/node/hello.js
sudo echo "const http = require('http');
const hostname = 'localhost';
const port = 3000;
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World !\n for LUIS ANDRES OLARTE ');
});
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});" > /var/www/node/hello.js
node /var/www/node/hello.js

curl http://localhost:3000

sudo npm install pm2@latest -g
pm2 start /var/www/node/hello.js
pm2 startup systemd
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u sammy --hp /home/sammy
pm2 startup systemd
pm2 save
sudo systemctl start pm2-sammy
systemctl status pm2-sammy
pm2 stop app_name_or_id
pm2 restart app_name_or_id
pm2 list
pm2 info app_name
pm2 monit
sudo nano /etc/nginx/sites-available/example.com
