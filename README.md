<!-- Para el código inicial del proyecto ver la siguiente ruta https://youtu.be/eMmRrpTrN0c -->
# parker-nginx-nodejs

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

![Permisos](/resources/Permiso.png)

**Paso 6:** Opcionalmente, puedes agregar etiquetas para el usuario en la sección "Add tags" (Agregar etiquetas). Una vez que hayas terminado, hacer clic en "Next: Review" (Siguiente: Revisar).

![Clave de acceso](/resources/Acceso.png)

**Paso 7:** Revisar la configuración del usuario en la página de revisión. Si todo está correcto, hacer clic en "Create user" (Crear usuario) para crear el usuario.

**Paso 8:** En la página de confirmación, hacer clic en **"Download .csv"** (Descargar .csv) para descargar un archivo CSV que contiene la clave de acceso y el secreto de acceso del usuario. Guardar esta información en un lugar seguro, ya que no podrás ver la clave de acceso nuevamente.

![Tipo de acceso](/resources/TipoAcceso.png)

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
![Variables de entorno](/resources/Variables.png)

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

## ¡Genial!

 Si todo se ejecutó sin errores, significa que has instalado correctamente el servidor MEAN (MongoDB, Express.js, Angular, Nginx, Node.js) y has creado un archivo de configuración de Nginx, así como un archivo de aplicación de ejemplo en Node.js. Ahora puedes acceder a tu servidor a través del nombre de dominio o la dirección IP que hayas configurado en la configuración de Nginx, y probar la funcionalidad de tu aplicación MEAN. Si tienes alguna pregunta o necesitas más ayuda, estaré encantado de asistirte.

![Tipo de acceso](/resources/successfully.png)

 
  **¡Buena suerte!**

