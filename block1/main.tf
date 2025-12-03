resource "aws_instance" "mage_interface"{
           
           instance_type = "mage_interface_instance_type"
           ami = "mage_interface_ami"
           key_name = "mage_interface_key_name""
           vpc_security_group_ids = "mage_interface_vpc_security_group_ids"
           disable_api_termination = "mage_interface_disable_api_termination"
           count = "mage_interface_count"
}