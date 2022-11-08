################################################################################
# Provider
################################################################################

provider "aws" {
  region = var.region
}

################################################################################
# Terraform settings block
################################################################################

terraform {
  required_version = "~> 1.3.0"
}

################################################################################
# Data blocks
################################################################################

data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

################################################################################
# Locals
################################################################################

locals {
  region = var.region
  name   = "alpha-ecs-${var.region}-cluster"

  tags = {
    CostCenter   = "1000-007"
    BusinessUnit = "Research"
    Data         = "Confidential"
    Criticality  = "Low"
  }
}

################################################################################
# Ecs Module
################################################################################

module "ecs" {
  source = "./modules/ecs"

  prefix      = var.prefix
  identifier  = var.identifier
  environment = var.environment

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        # You can set a simple string and ECS will create the CloudWatch log group for you
        # or you can create the resource yourself as shown here to better manage retention, tagging, etc.
        # Embedding it into the module is not trivial and therefore it is externalized
        cloud_watch_log_group_name = aws_cloudwatch_log_group.this.name
      }
    }
  }

  # Capacity provider
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${local.name}"
  retention_in_days = 7

  tags = local.tags
}

################################################################################
# ECS Service Load Balancer
################################################################################
module "ecs_load_balancer" {
  source = "./modules/ecs-service-elb"

  prefix      = var.prefix
  identifier  = var.identifier
  environment = var.environment

  region     = var.region
  vpc_id     = data.aws_vpc.default_vpc.id
  subnet_ids = data.aws_subnets.subnets.ids

  service_name = "travelperk-app"
  service_port = "8080"

  health_check_path = "/"

  allow_cidrs = ["0.0.0.0/0"]

  expose_to_public_internet = "yes"

  tags = local.tags
}

################################################################################
# ECS Service
################################################################################
module "ecs_service" {
  source = "./modules/ecs-service"

  prefix      = var.prefix
  identifier  = var.identifier
  environment = var.environment

  region = var.region
  vpc_id = data.aws_vpc.default_vpc.id

  service_launch_type       = "FARGATE"
  service_task_network_mode = "awsvpc"
  task_cpu                  = 256
  task_memory               = 512

  service_name   = "travelperk-app"
  service_image  = "karalegb/travelperk-app"
  service_port   = "5000"
  service_cpu    = 10
  service_memory = 256

  service_desired_count                      = "3"
  service_deployment_maximum_percent         = "200"
  service_deployment_minimum_healthy_percent = "100"

  target_group_arn   = module.ecs_load_balancer.target_group_arn
  target_port        = "5000"
  service_role       = data.aws_iam_role.task_ecs.arn
  execution_role_arn = data.aws_iam_role.task_ecs.arn

  subnet_ids = data.aws_subnets.subnets.ids

  service_volumes = [
    {
      name = "data"
    }
  ]

  ecs_cluster_id               = module.ecs.cluster_arn
  ecs_cluster_service_role_arn = data.aws_iam_role.task_ecs.arn

  tags = local.tags
}


