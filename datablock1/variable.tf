variable "ps2_ami" {
  default = "ami-0d2aad4794ad02001"
}

variable "ps2_instance_type" {
  default = "t3.micro"
}

variable "ps2_key_name" {
  default = "new"
}

variable "ps2_vpc_security_group_ids" {
  default =  "sg-0433d16371e383fbd"
}

variable "ps2_disable_api_termination" {
  default = false
}
