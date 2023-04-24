packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu_ami_image" {
  ami_name      = "ubuntu_nodejs_laoz"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-0e4a0595b254f1a4f"
  tags = {
    Name = "Ubuntu_NodeJS_LAOZ"
  }
  ssh_username = "ubuntu"
}

build {
  name    = "ubuntu_nodejs_laoz"
  sources = ["source.amazon-ebs.ubuntu_ami_image"]
  provisioner "shell" {
    script = "install.sh"
  }
}