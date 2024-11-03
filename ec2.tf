resource "aws_default_vpc" "this" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "app" {
  ami           = "ami-0acc77abdfc7ed5a6"
  instance_type = "t2.micro"
  key_name      = "collinsefe"
  # subnet_id              = var.subnet_id
  # iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app_security_group.id]
  user_data                   = file("./app_install.sh")
  # user_data_replace_on_change = true

  tags = {
    Name = "App-Server"
  }
}
