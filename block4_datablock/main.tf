resource "aws_instance" "ps2" {
    ami = var.ps2_ami
    instance_type = var.ps2_instance_type
    key_name = var.ps2_key_name
    vpc_security_group_ids = [var.ps2_vpc_security_group_ids , aws_security_group.vcom.id , data.aws_security_group.data_vcom_sg.id ]
    disable_api_termination = var.ps2_disable_api_termination

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                cat <<HTML > /var/www/html/index.html
                <!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ghost Reverie — PS2</title>
  <style>
    body {
      margin: 0;
      font-family: 'Cinzel', serif;
      background: #02070d;
      color: #e8ffff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      padding: 0;
    }

    .landscape-wrapper {
      width: 90%;
      max-width: 1400px;
      background: #000;
      border-radius: 12px;
      overflow: hidden;
      display: flex;
      flex-direction: row;
      box-shadow: 0 0 60px rgba(0,255,255,0.25);
      border: 2px solid #0a121a;
    }

    /* Left side — full cover art */
    .cover-art {
      flex: 3;
      background-image: url('https://i.pinimg.com/736x/79/ef/cb/79efcba9f7b39671956f31cbd944293e.jpg');
      background-size: cover;
      background-position: center;
      height: 100%;
      min-height: 650px;
    }

    /* Right panel */
    .info-panel {
      flex: 1.2;
      background: #020c12;
      padding: 30px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      border-left: 2px solid #052027;
    }

    .ps2-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 28px;
      color: white;
      margin-bottom: 20px;
    }

    .ntsc {
      background: white;
      color: black;
      font-size: 12px;
      padding: 4px 6px;
      border-radius: 3px;
    }

    .title {
      font-size: 48px;
      letter-spacing: 3px;
      color: #8E9E93;
      text-shadow: 0 0 18px rgba(0,255,255,0.5);
      margin: 40px 0;
    }

    .esrb {
      width: 90px;
    }
  </style>
</head>
<body>

<div class="landscape-wrapper">

  <div class="cover-art"></div>

  <div class="info-panel">

    <div class="ps2-header">
      <div>PlayStation 2</div>
      <div class="ntsc">NTSC U/C</div>
    </div>

    <div class="title">SILENT<br>HILL </div>

    

  </div>

</div>

</body>
</html>
HTML
EOF

}

resource "aws_security_group" "vcom" {

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress {
       from_port = 8080
       to_port   = 8080
       protocol  = "tcp"
       cidr_blocks = ["0.0.0.0/0"]

   } 

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    
}

output "ps2_public_ip"{
    value = aws_instance.ps2.public_ip 
}
output "ps2_public_dns"{
    value = aws_instance.ps2.public_dns 
}
output "vcom_id"{
    value = aws_security_group.vcom.id 
}
output "vcom_arn"{
    value = aws_security_group.vcom.arn
}

data "aws_security_group" "data_vcom_sg" {
    name = "launch-wizard-2"
}

data "aws_ami" "data_vcom_ami" {
    most_recent = true

    filter {
        name = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

      owners = ["amazon"] 
}
 
 data "aws_instance" "data_webserver_instance" {
  instance_id = "i-0e74f64693094a6b9"
}