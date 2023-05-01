packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
source "amazon-ebs" "ubuntu_ami_image" {
  ami_name      = "ami_laoz_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-0e4a0595b254f1a4f"
  source_ami_filter {
    filters = {
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  tags = {
    Name = "AMI_LAOZ_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
    Distro = "ubuntu-jammy-22.04-amd64"
  }
  ssh_username = "ubuntu"
}
build {
  name = "build_${replace(replace(replace(timestamp(), "-", ""), ":", ""), " ", "")}"
  sources = [
    "source.amazon-ebs.ubuntu_ami_image"
  ]
  provisioner "file" {
    source      = "resources/files/server.js"
    destination = "/home/ubuntu/server.js"
  }
  provisioner "file" {
    source      = "resources/files/default"
    destination = "/home/ubuntu/default"
  }
  provisioner "shell" {
    script = "resources/files/install.sh"
  }
}