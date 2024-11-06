terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "ec2" {
  source = "./modules/ec2"

  ami_id        = local.ami_id
  instance_type = local.instance_type
  key_name      = local.key_name
  # subnet_id     = var.subnet_id
  user_data = local.user_data
}

module "ecrDevRepo" {
  source        = "./modules/ecr"
  ecr_repo_name = "${local.ecr_repo_name}-dev"
}

module "ecrTestRepo" {
  source        = "./modules/ecr"
  ecr_repo_name = "${local.ecr_repo_name}-test"
}

module "ecsTestCluster" {
  source = "./modules/ecs"

  app_cluster_name   = "${local.app_cluster_name}-test"
  availability_zones = local.availability_zones

  app_task_family              = "app-task-test" 
  ecr_repo_url                 = module.ecrTestRepo.repository_url
  container_port               = local.container_port
  app_task_name                = "${local.app_task_name}-test"
  ecs_task_execution_role_name = "${local.ecs_task_execution_role_name}-test"

  application_load_balancer_name = "${local.application_load_balancer_name}-test"
  target_group_name              = "${local.target_group_name}-test"
  app_service_name               = "${local.app_service_name}-test"
}

module "ecsDevCluster" {
  source = "./modules/ecs"

  app_cluster_name   = "${local.app_cluster_name}-dev"
  availability_zones = local.availability_zones

  app_task_family              = "app-task-dev" 
  ecr_repo_url                 = module.ecrDevRepo.repository_url
  container_port               = local.container_port
  app_task_name                = "${local.app_task_name}-dev"
  ecs_task_execution_role_name = "${local.ecs_task_execution_role_name}-dev"

  application_load_balancer_name = "${local.application_load_balancer_name}-dev"
  target_group_name              = "${local.target_group_name}-dev"
  app_service_name               = "${local.app_service_name}-dev"
}


module "s3" {
  source      = "./modules/s3"
  artifact_bucket_name = local.artifact_bucket_name
}

