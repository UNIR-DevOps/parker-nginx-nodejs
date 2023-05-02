
// Definimos el complemento requerido, que es el complemento "amazon" de HashiCorp. 
packer {
  required_plugins {
    // Este complemento permite a Packer interactuar con Amazon Web Services
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
// Se define la fuente de la imagen de Amazon EBS que se utilizará para construir la imagen de la máquina virtual.
source "amazon-ebs" "ubuntu_ami_image" {
  // Se especifica el nombre de la AMI (Amazon Machine Image) que se creará, con un nombre basado en la fecha y hora actual.
  ami_name      = "ami_laoz_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
  // Se especifica el tipo de instancia, la región y la AMI
  instance_type = "t2.micro"
  region        = "us-west-2"
  // Se especifica la AMI de origen que se utilizará para construir la nueva imagen.
  source_ami    = "ami-0e4a0595b254f1a4f"
  // Se especifica el tipo de instancia, la región y 
  source_ami_filter {
    filters = {
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    // Se definen algunos filtros para obtener la última AMI que sea compatible con la configuración deseada y pertenezca al propietario 
    owners      = ["099720109477"]
  }
  // Se definen algunas etiquetas para la nueva AMI que se creará
  tags = {
    Name = "AMI_LAOZ_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
    Distro = "ubuntu-jammy-22.04-amd64"
  }
  ssh_username = "ubuntu"
}
// Se define el proceso de construcción de la imagen de la máquina virtual.
build {
  name = "build_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
  // Se especifica la fuente de la imagen de la máquina virtual, que en este caso es la fuente "amazon-ebs
  sources = [
    "source.amazon-ebs.ubuntu_ami_image"
  ]
  // Se especifica una serie de pasos de aprovisionamiento, que se ejecutarán en la imagen de la máquina virtual durante la construcción. 
  
  // El primer archivo es "server.js" 
  provisioner "file" {
    // Se copian dos archivos desde el directorio "resources/files" 
    source      = "resources/files/server.js"
    // El destino el directorio "/home/ubuntu" 
    destination = "/home/ubuntu/server.js"
  }
  // El segundo es "default"
  provisioner "file" {
    // Se copian dos archivos desde el directorio "resources/files" 
    source      = "resources/files/default"
    // El destino el directorio "/home/ubuntu" 
    destination = "/home/ubuntu/default"
  }
  // Se ejecuta un script de shell ubicado en el archivo "resources/files/install.sh".
  provisioner "shell" {
    script = "resources/files/install.sh"
  }
}