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

## 3. Ejecutar packer

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