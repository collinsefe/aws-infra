resource "aws_security_group" "appserverSecurityGroup" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Appserver SecurityGroup"
    Project = "Collins Demo"
  }
}

resource "aws_lb" "LoadBalancer" {
  load_balancer_type = "application"
  subnets            = [var.my_public_subnets[0].id, var.my_public_subnets[1].id]
  security_groups    = [aws_security_group.appserverSecurityGroup.id]
  tags = {
    Name    = "LoadBalancer"
    Project = "Collins Demo"
  }
}

resource "aws_lb_listener" "LbListener" {
  load_balancer_arn = aws_lb.LoadBalancer.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.TargetGroup.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "TargetGroup" {
  name     = "example-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name    = "TargetGroup"
    Project = "Collins Demo"
  }
}

resource "aws_lb_target_group_attachment" "appserver1" {
  target_group_arn = aws_lb_target_group.TargetGroup.arn
  target_id        = aws_instance.appserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "appserver2" {
  target_group_arn = aws_lb_target_group.TargetGroup.arn
  target_id        = aws_instance.appserver2.id
  port             = 80
}

resource "aws_instance" "appserver1" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.my_public_subnets[0].id
  security_groups             = [aws_security_group.appserverSecurityGroup.id]
  associate_public_ip_address = true
   tags = {
    Name    = "app server 1"
    Project = "Collins Demo"
  }
}


resource "aws_instance" "appserver2" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.my_public_subnets[0].id
  security_groups             = [aws_security_group.appserverSecurityGroup.id]
  associate_public_ip_address = true
  tags = {
    Name    = "app server 2"
    Project = "Collins Demo"
  }
}
  
