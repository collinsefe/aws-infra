locals {
  
# VPC
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  table_name  = "CollinsDemo"
  
# ECR
  ecr_repo_name = "cap-gem-app"

# ECS 
  app_cluster_name             = "app-cluster"
  app_task_family              = "app-task"
  container_port               = 80
  app_task_name                = "app-task"
  ecs_task_execution_role_name = "app-task-execution-role"
  application_load_balancer_name = "app-alb"
  target_group_name              = "alb-tg"
  app_service_name = "app-service"
  
# EC2 Instance
  ami_id        = "ami-0acc77abdfc7ed5a6"
  instance_type = "t2.micro"
  key_name      = "collinsefe"
  user_data = file("./app_install.sh")

  artifact_bucket_name = "cap-gem-artifact-bucket-06112024"
}


