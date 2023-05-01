const http = require('http');
const hostname = 'localhost';
const port = 3000;
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World ! for LUIS ANDRES OLARTE ');
});
server.listen(port, hostname, () => {
  console.log(`\n\033[0;33mServer running at http://${hostname}:${port}/ for LUIS ANDRES OLARTE \033[0;36m\n\n`);
});