provider "aws" {
    region = "eu-north-1"
    profile = "configs"
}

resource "aws_instance" "ginger" {
    instance_type = "t3.micro"
    ami = ami-0b46816ffa1234887
    key_name = "new"
    vpc_security_group_ids = "sg-05d8d9380629ad735"

    provisioner "file" {
        source = "textdata.txt"
        destination = "/home/ec2-user/aws/"
    }

    provisioner "local-exec" {
         command = "echo ${self.private_ip} >> private_ips.txt" 
    }
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("${path.module}/tf.pem")
        host = self.public_ip
    }

    provisioner "remote-exec" {
    inline = [

      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
   }
   
 }
