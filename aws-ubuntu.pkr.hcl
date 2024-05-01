packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "ubuntu" { // builder 
  ami_name      = "papaaa"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-04b70fa74e45c3917"
  ssh_username  = "ubuntu"
}

build {
  name = "build-ubuntu"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",       # Example: Installing Nginx
      "sudo systemctl enable nginx",     # Enable Nginx to start on boot
      "sudo systemctl start nginx"   
    ]
  }

//   post-processor "vagrant" {
//       keep_input_artifact = true
//       provider_override   = "virtualbox"
//     }
   post-processor "compress" {} # Compress the image

}



