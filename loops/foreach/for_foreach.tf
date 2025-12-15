provider "aws" {
     region = "eu-north-1"
     profile = "configs"
}

resource "aws_instance" "plum" {
    instance_type = "t3.micro"
    ami = each.value
    for_each = toset(var.ami_foreach)
}

variable "ami_foreach" {

    default = default = [ "ami-0b46816ffa1234887" , "ami-0fa91bc90632c73c9" ]

}

resource "aws_iam_user" "iam" {
    name = each.value
    for_each = toset(var.iamrole)
}

variable = "iamrole" {
    default = [ "ming" , "mini" , "meoww" ]
}

output "aws_id" {

    value = [
        for amiid in var.ami_foreach:
        aws_instance.plum[amiid].id
    ]
}


