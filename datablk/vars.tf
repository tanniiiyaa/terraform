variable "webserver_instance_type" {
  default = "t3.micro"
}

variable "webserver_ami" {
  default = "ami-0d2aad4794ad02001"
}

variable "webserver_key_name" {
  default = "nana"
}

variable "webserver_vpc_security_group_ids" {
  default = "sg-05d8d9380629ad735"
}

variable "webserver_disable_api_termination" {
  default = false
}

