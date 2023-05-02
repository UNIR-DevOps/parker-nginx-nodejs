// Se importa el módulo http para crear un servidor web.
const http = require('http');
// Definimos el puerto en el que se va a ejecutar el servidor.
const port = 3000;
// Se crea un servidor con el paquete http que es básico de nodejs.
const server = http.createServer((req, res) => {
  // Se establecen las respuestas que el servidor proporcionará a las solicitudes entrantes.
  // Respuesta con código exitoso
  res.statusCode = 200;
  // Se define el formato de la respuesta como texto plano
  res.setHeader('Content-Type', 'text/plain');
  // Respuesta del servicio
  res.end('Hello World ! for LUIS ANDRES OLARTE ');
  // Se muestra mensaje en la consola como log del consumo del servicio
  console.log('Hello World ! for LUIS ANDRES OLARTE ');
});
// Se establecen las respuestas que el servidor proporcionará a las solicitudes entrantes.
server.listen(port, hostname, () => {
  // Se muestra mensaje en la consola como log del inicio del servicio
  console.log(`Server running at http://localhost:${port}/ for LUIS ANDRES OLARTE`);
});