provider "aws" {
     region = "eu-north-1"
     profile = "configs"
}

## instance
resource "aws_instance" "demo" {
         instance_type = var.instance_type
         ami = var.ami
         key_name = var.key_name
         vpc_security_group_ids = [ var.sg ]
}