resource "aws_default_vpc" "default_vpc" {}


resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
#   subnet_id     = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app_security_group.id]
  user_data                   = var.user_data
  user_data_replace_on_change = false

  tags = {
    Name = "app-server"
  }
}
