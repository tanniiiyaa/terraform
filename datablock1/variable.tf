variable "ps2_ami" {
  default = "ami-0d2aad4794ad02001"
}

variable "ps2_instance_type" {
  default = "t3.micro"
}

variable "ps2_key_name" {
  default = "nana"
}

variable "ps2_vpc_security_group_ids" {
  default = "sg-05d8d9380629ad735"
}

variable "ps2_disable_api_termination" {
  default = false
}
