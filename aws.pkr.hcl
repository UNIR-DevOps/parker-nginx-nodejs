packer {
    required_plugins {
        amazon = {
            version = ">= 0.0.2"
            source = "github.com/hashicorp/amazon"    
        }
    }    
}

source "amazon-ebs" "ubuntu_ami_image" {
    ami_name = "ubuntu_jammy_golden_image"
    instance_type = "t2.micro"
    region = "us-west-2"
    source_ami_filter = {
        filters = {
            name = "ubuntu/server/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20221201"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }
        most_recent = true
        owners = ["540587434366"]
        tags = {
            Name = "Ubuntu_Jammy_Golden_Image"
        }
        ssh_username = "ubuntu"
    }    
}

build {
    name = "ubuntu_jammy_golden_image"
    sources = ["source.amazon-ebs.ubuntu_ami_image"]
    provisioner "shell" {
        script = "install.sh"
    }
}