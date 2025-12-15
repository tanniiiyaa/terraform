variable "keyname_fox" {
    type = string
    default = "tf"
}

variable "count_fox" {
    type = number
    default = 2
}

variable "instancetype_fox" {
    type = list
    default = ["t3.micro"  , "t3.small"]
}

variable "ami_fox" {
    type = map
    default = {
        ami_id = "ami-0fa91bc90632c73c9"
        ami_idamz = "ami-0b46816ffa1234887"
    }
}

variable "any_fox" {
    type = any
    default = {
        keyname_fox = "nana"
        count = 1
        ami_ec2 = "ami-01fd6fa49060e89a6"
        instance_type_list = ["t3.micro" , "t3.small" ]
            }
}