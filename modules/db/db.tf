resource "aws_db_subnet_group" "DBSubnetGroup" {
  name = "-db-subnet-group"
  subnet_ids = [
    var.my_private_subnets[0].id,
    var.my_private_subnets[1].id
  ]
  tags = {
    Name    = "DBSubnetGroup"
    Project = "COLLINS Demo"
  }
}

resource "aws_security_group" "DBSecurityGroup" {
  name   = "-db-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      var.my_private_subnet_cidrs[0],
      var.my_private_subnet_cidrs[1]
    ]
  }
  tags = {
    Name    = "DBSecurityGroup"
    Project = "COLLINS Demo"
  }
}

resource "aws_db_instance" "RDS" {
  availability_zone      = var.db_az
  db_subnet_group_name   = aws_db_subnet_groupDBSubnetGroup.name
  vpc_security_group_ids = [aws_security_groupDBSecurityGroup.id]
  allocated_storage      = 20
  storage_type           = "standard"
  engine                 = "postgres"
  engine_version         = "12"
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user_name
  password               = var.db_user_password
  skip_final_snapshot    = true
  tags = {
    Name    = "RDS"
    Project = "COLLINS Demo"
  }
}