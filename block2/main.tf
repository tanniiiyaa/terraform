resource "aws_instance" "hayabusa" {

     ami = var.hayabusa_ami
     vpc_security_group_ids = [var.hayabusa_vpc_security_group_ids , aws_security_group.hanabi.id ]
     instance_type = var.hayabusa_instance_type
     key_name = var.hayabusa_key_name
     disable_api_termination = var.hayabusa_disable_api_termination

}

resource "aws_security_group" "hanabi" {

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
 
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks - ["0.0.0.0/0"]
    }
     
}

output "hanabi_public_ip" {
    value = aws_instance.hayabusa.public_ip
}

output "hanabi_public_dns" {
    value = aws_instance.hayabusa.public_dns
}

output "hanabi_sg_id" {
    value = aws_security_group.hanabi.id
}

output "hanabi_sg_arn" {
    value = aws_security_group.hanabi.arn
}