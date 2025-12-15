# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets under default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Use existing Internet Gateway (IGW) of the default VPC
data "aws_internet_gateway" "default_igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate all default subnets with public route table
resource "aws_route_table_association" "public_assoc" {
  for_each       = toset(data.aws_subnets.default.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}

# Security Group

resource "aws_security_group" "web_sgroup" {
  name   = "web-sg1"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg1"
  }
}


# Load Balancer

resource "aws_lb" "app_lb" {
  name               = "simple-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sgroup.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "tag" {
  name     = "simple-tag"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tag.arn
  }
}


# Launch Template

resource "aws_launch_template" "example" {
  name_prefix   = "simple-template-"
  image_id      = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sgroup.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "I Am... The Ghost of the Uchiha $(hostname)" > /var/www/html/index.html
            EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = data.aws_subnets.default.ids
  target_group_arns         = [aws_lb_target_group.tag.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
}

# Output
output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
