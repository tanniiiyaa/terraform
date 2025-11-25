resource "aws_instance" "kuromi" {

    instance_type = "t3.micro"
    ami = "ami-0d2aad4794ad02001"
    key_name = "terra"
    vpc_security_group_ids = [ "sg-024eddf4176040594" ]
}