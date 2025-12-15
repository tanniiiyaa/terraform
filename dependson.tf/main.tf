#instance
resource "aws_instance" "alpha" {
    ami = var.ami_fox.ami_id
    instance_type = var.any_fox.instancetype_fox[1]
    key_name = var.any_fox.keyname_fox
    count = var.count_fox
}

resource "aws_instance" "beta" {
    ami = var.ami_fox.ami_idamz
    instance_type = var.instancetype_fox[0]
    key_name = var.any_fox.keyname_fox
    count = var.count_fox
}

#security groups

resource "aws_security_group" "sg" {
    depends on [aws_instance.alpha]
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
        cidr_blocks = ["0.0.0.0/0"]
    }
}

