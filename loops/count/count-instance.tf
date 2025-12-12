#This block creates two identical EC2 instances using the same AMI.

resource "aws_instance" "onion" {
    instance_type = "t3.micro"
    ami = "ami-0fa91bc90632c73c9"
    count = 2
}

## Creates multiple EC2 instances, each with a different AMI, using count and list indexing.

resource "aws_instance" "tomato" {
    instance_type = "t3_micro"
    ami = var.ami_list[count.index]
    count = length(var.ami_list) 
}

variable "ami_list" {
    default = [ "ami-0b46816ffa1234887" , "ami-0fa91bc90632c73c9" ]
}