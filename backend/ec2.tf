terraform {
    backend "s3" {
        bucket = "tf-demo-buckyy"
        key = "terraform.tfstate"
        dynamodb_table = "dynao-demo"
        region = "eu-north-1"
        profile = "configs"
        shared_credentials_files = ["/home/tan/.aws/credentials"]
    }
}

resource "aws_instance" "sunflower" {
    instance_type = "t3.micro"
    ami = "ami-0fa91bc90632c73c9"
    key_name = "nana"
    vpc_security_group_ids = [ "sg-05d8d9380629ad735" ]
}