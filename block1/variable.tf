variable "mage_interface_ami" {
    default = "ami-0d2aad4794ad02001"
}
variable "mage_interface_instance_type" {
    default = "t3.micro"
}
variable "mage_interface_key_name" {
    default = "nana"
}
variable "mage_interface_disable_api_termination" {
    default = true
}
variable "mage_interface_vpc_security_group_ids" {
    default = ["sg-05d8d9380629ad735"]
}
variable "mage_interface_count" {
    default = 4
}