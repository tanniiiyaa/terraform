variable "hayabusa_ami" {
    default = "ami-0d2aad4794ad02001"
}
variable "hayabusa_instance_type" {
    default = "t3.micro"
}
variable "hayabusa_key_name" {
    default = "nana"
}
variable "hayabusa_vpc_security_group_ids" {
    default = "sg-05d8d9380629ad735"
}
variable "hayabusa_disable_api_termination" {
    default = false 
}