<!-- Para el código inicial del proyecto ver la siguiente ruta https://youtu.be/eMmRrpTrN0c -->
# parker nginx nodejs

Esta plantilla de Packer utiliza el builder de **Amazon EBS** para crear una imagen de **Amazon Machine Image (AMI)** de AWS. Luego, utiliza los provisioners de shell para instalar **Node.js, npm, pm2 y Nginx** en la instancia, clonar el repositorio de la aplicación Node.js desde la URL especificada, instalar las dependencias de la aplicación, iniciar la aplicación con pm2 y configurar pm2 y Nginx para que se inicien automáticamente en el arranque del sistema.

## 1. Instalación de dependencias

### 1.1. Instalar Chocolatey

Para comenzar, necesitarás instalar Chocolatey, una herramienta de administración de paquetes para Windows. Puedes descargarla desde la siguiente ruta: [Chocolatey](https://chocolatey.org/install#individual)

En Windows, ejecuta el siguiente comando en PowerShell como administrador:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 1.2. Instalar Packer

Una vez que hayas instalado Chocolatey, puedes utilizarlo para instalar Packer, una herramienta de automatización para crear imágenes de máquinas virtuales. Puedes descargar Packer desde la siguiente ruta: [Packer CLI](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

En Windows, ejecuta el siguiente comando en PowerShell como administrador para instalar Packer con Chocolatey:

```powershell
choco install packer
```

## 2. Configurar AWS usuario AMI

**Paso 1:** Iniciar sesión en la consola de AWS y navegar a IAM.

**Paso 2:** En el panel de navegación de IAM, seleccionar "Users" (Usuarios).

**Paso 3:** Hacer clic en "Add user" (Añadir usuario) para crear un nuevo usuario.

**Paso 4:** Ingresar un nombre de usuario y marcar la opción "Programmatic access" (Acceso programático) para habilitar el acceso a través de la AWS CLI. Luego, hacer clic en "Next: Permissions" (Siguiente: Permisos).

**Paso 5:** En la sección de "Set permissions" (Establecer permisos), seleccionar "Attach existing policies directly" (Adjuntar directamente políticas existentes) y buscar la política necesaria para el usuario. Puedes buscarla por nombre o filtrar por categoría. Seleccionar la política requerida y hacer clic en "Next: Tags" (Siguiente: Etiquetas) cuando hayas terminado.

![Permisos](/resources/img/Permiso.png)

**Paso 6:** Opcionalmente, puedes agregar etiquetas para el usuario en la sección "Add tags" (Agregar etiquetas). Una vez que hayas terminado, hacer clic en "Next: Review" (Siguiente: Revisar).

![Clave de acceso](/resources/img/Acceso.png)

**Paso 7:** Revisar la configuración del usuario en la página de revisión. Si todo está correcto, hacer clic en "Create user" (Crear usuario) para crear el usuario.

**Paso 8:** En la página de confirmación, hacer clic en **"Download .csv"** (Descargar .csv) para descargar un archivo CSV que contiene la clave de acceso y el secreto de acceso del usuario. Guardar esta información en un lugar seguro, ya que no podrás ver la clave de acceso nuevamente.

![Tipo de acceso](/resources/img/TipoAcceso.png)

## 3. Variables de entorno

Para configurar las variables de entorno en tu máquina local para usar la clave de acceso

En **Linux y MAC** puedes abrir una terminal y ejecutar los siguientes comandos, reemplazando los valores correspondientes:

```powershell
export AWS_ACCESS_KEY_ID=<clave_de_acceso>
export AWS_SECRET_ACCESS_KEY=<secreto_de_acceso>
```

En **Windows**, para configurar las variables de entorno necesarias para Nginx y Node.js, puedes seguir estos pasos:

**Paso 1:** Abrir el Panel de control

Haz clic en el botón de "Inicio" en la barra de tareas de Windows.
Busca "Panel de control" en la barra de búsqueda y selecciona la opción correspondiente para abrir el Panel de control.

**Paso 2:** Acceder a la configuración de las variables de entorno

En el Panel de control, busca y selecciona la opción "Sistema".
Haz clic en "Configuración avanzada del sistema" en la columna de la izquierda.
En la ventana "Propiedades del sistema" que se abre, selecciona la pestaña "Opciones avanzadas".
Haz clic en el botón "Variables de entorno" en la parte inferior de la ventana.

**Paso 3:** Configurar las variables de entorno
![Variables de entorno](/resources/img/Variables.png)

**Paso 4:** Aplicar los cambios

## 4. Ejecutar Packer

Con Packer instalado, ahora puedes ejecutarlo para comenzar a crear tus imágenes de máquinas virtuales. Sigue estos pasos:

Abre una consola en la ubicación de tu proyecto.
Ejecuta el siguiente comando para inicializar la configuración de Packer en tu proyecto:

```powershell
packer init .
```

Al finalizar, ejecutar este comando:

```powershell
packer build aws.pkr.hcl
```

## 5. Ejecución del proyecto

 Si todo se ejecutó sin errores, significa que has instalado correctamente el servidor (Nginx, pm2 y Node.js) y has creado un archivo de configuración de Nginx, así como un archivo de aplicación de ejemplo en Node.js. Ahora puedes acceder a tu servidor a través del nombre de dominio o la dirección IP que hayas configurado en la configuración de Nginx, y probar la funcionalidad de tu aplicación.

Inicialmenete al ejecutar el script [aws.pkr.hcl](/aws.pkr.hcl) se conecta a la nube a traves de las credenciales de las variables de entorno y crea una nueva instancia a traves de las caracteristicas definidas en el source:

![Evidencia 1](/resources/img/Carga1.png)

En este punto inicia el proceso de ejecución del script que se encuentra en [install.sh](resources/files/install.sh) e inicia con la actualización de la herramienta **"apt-get"** para instalar, actualizar y desinstalar paquetes de software desde los repositorios oficiales del sistema:

![Evidencia 2](/resources/img/Carga2.png)

En este punto inicia la ejecución del proceso de instación de **"Node.js"** que es  es un entorno de tiempo de ejecución de JavaScript que se utiliza principalmente para desarrollar aplicaciones web en el lado del servidor. Node.js es una plataforma de programación basada en eventos y se enfoca en la escalabilidad y el rendimiento:

![Evidencia 3](/resources/img/Carga3.png)

Finaliza el proceso de instalación de **"Node.js"**:

![Evidencia 4](/resources/img/Carga4.png)

Se actualiza el paquete **"build-essential"** que incluye una serie de herramientas y bibliotecas esenciales para compilar y construir programas desde su código fuente:

![Evidencia 5](/resources/img/Carga5.png)

Aquí instalamos el paquete **"PM2"** que se utiliza comúnmente con **"Nginx"** para gestionar y escalar aplicaciones **"Node.js"** en un entorno de producción.

![Evidencia 6](/resources/img/Carga6.png)

Instalación de la herramienta **"Nginx"** es un servidor web y proxy inverso, lo que significa que se utiliza para gestionar las solicitudes de los clientes y responder a ellas de manera eficiente:

![Evidencia 7](/resources/img/Carga7.png)

Finaliza el proceso de instalación de **"Nginx"**:

![Evidencia 8](/resources/img/Carga8.png)

En esta imagen se ve como inicia y se habilita el paquete **"Nginx"**, seguido se copian dos archivos desde el directorio **"resources/files"** **"server.js"** y **"default"**:

![Evidencia 9](/resources/img/Carga9.png)

Finalmente se reinicia el paquete **"PM2"**:

![Evidencia 11](/resources/img/Carga11.png)

En este punto vemos que se finaliza la ejecución del script y al final el mensaje de creación exitosa del **"AMI"** entregado por **"AWS"**:

![Evidencia 10](/resources/img/Carga10.png)

En este apartado he resaltado el mensaje de ejecución exitosa del comando  **"curl"** que usamos para recuperar la respuesta del servicio que fue instalado en servidor  **"EC2"** de  **"AWS"** seguido del resultado de la prueba en color verde.

![Evidencia 10](/resources/img/Carga12.png)

El texto completo de la ejecución del proceso se encuentra en la ruta: [Logs](/logs/Windows%20PowerShell%20Packer%20build.txt)

Si tienes alguna pregunta o necesitas más ayuda, estaré encantado de ayudarte.