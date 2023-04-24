<!-- Para el código inicial del proyecto ver la siguiente ruta https://youtu.be/eMmRrpTrN0c -->
# parker-nginx-nodejs

## 1. Instalar Chocolatey

Para comenzar, necesitarás instalar Chocolatey, una herramienta de administración de paquetes para Windows. Puedes descargarla desde la siguiente ruta: [Chocolatey](https://chocolatey.org/install#individual)

En Windows, ejecuta el siguiente comando en PowerShell como administrador:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## 2. Instalar packer

Una vez que hayas instalado Chocolatey, puedes utilizarlo para instalar Packer, una herramienta de automatización para crear imágenes de máquinas virtuales. Puedes descargar Packer desde la siguiente ruta: [Packer CLI](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli) 

En Windows, ejecuta el siguiente comando en PowerShell como administrador para instalar Packer con Chocolatey:

```powershell
choco install packer
```
## 3. Caracteristicas de usuario AMI AWS

1: Iniciar sesión en la consola de AWS y navegar a IAM.

2: En el panel de navegación de IAM, seleccionar "Users" (Usuarios).

3: Hacer clic en "Add user" (Añadir usuario) para crear un nuevo usuario.

4: Ingresar un nombre de usuario y marcar la opción "Programmatic access" (Acceso programático) para habilitar el acceso a través de la AWS CLI. Luego, hacer clic en "Next: Permissions" (Siguiente: Permisos).

5: En la sección de "Set permissions" (Establecer permisos), seleccionar "Attach existing policies directly" (Adjuntar directamente políticas existentes) y buscar la política necesaria para el usuario. Puedes buscarla por nombre o filtrar por categoría. Seleccionar la política requerida y hacer clic en "Next: Tags" (Siguiente: Etiquetas) cuando hayas terminado.

![Permisos](/resources/Permiso.png)

 6: Opcionalmente, puedes agregar etiquetas para el usuario en la sección "Add tags" (Agregar etiquetas). Una vez que hayas terminado, hacer clic en "Next: Review" (Siguiente: Revisar).

![Clave de acceso](/resources/Acceso.png)


7: Revisar la configuración del usuario en la página de revisión. Si todo está correcto, hacer clic en "Create user" (Crear usuario) para crear el usuario.

8: En la página de confirmación, hacer clic en "Download .csv" (Descargar .csv) para descargar un archivo CSV que contiene la clave de acceso y el secreto de acceso del usuario. Guardar esta información en un lugar seguro, ya que no podrás ver la clave de acceso nuevamente.

![Tipo de acceso](/resources/TipoAcceso.png)

9: Para configurar las variables de entorno en tu máquina local para usar la clave de acceso, puedes abrir una terminal y ejecutar los siguientes comandos, reemplazando los valores correspondientes:

En Linux y MAC:

```powershell
export AWS_ACCESS_KEY_ID=<clave_de_acceso>
export AWS_SECRET_ACCESS_KEY=<secreto_de_acceso>
```

Para windows configure las variables de entorno:

![Variables de entorno](/resources/Variables.png)

## 4. Ejecutar packer

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