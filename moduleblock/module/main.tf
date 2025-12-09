module "ec2" {
    source = "/home/tan/terraform/moduleblock/main/EC2"
    webserver_ami = "ami-0fa91bc90632c73c9"
    webserver_instance_type = "t3.micro"
    webserver_key_name = "nana"
    webserver_disable_api_termination = false
    webserver_subnetA = module.vpc.subnet_id
    webserver_sg = module.vpc.webserver_sg
}

module "vpc" {

    source = "/home/tan/terraform/moduleblock/main/VPC"
    vpc_cidr = "172.30.0.0/16"
    vpc_subnetA = "172.30.128.0/20" 
    public_ip = true
}