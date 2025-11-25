resource "aws_instance" "kuromi" {

    instance_type = "t3.micro"
    ami = "ami-0d2aad4794ad02001"
    key_name = "launch-wizard-2"
    vpc_security_group_ids = [ "sg-05d8d9380629ad735" ]
}