resource "aws_instance" "mage_interface" {

  instance_type           = var.mage_interface_instance_type
  ami                     = var.mage_interface_ami
  key_name                = var.mage_interface_key_name
  vpc_security_group_ids = var.mage_interface_vpc_security_group_ids
  disable_api_termination = var.mage_interface_disable_api_termination
  count                   = var.mage_interface_count
}
