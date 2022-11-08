################################################################################
# ECS Cluster
################################################################################

resource "aws_ecs_cluster" "this" {
  count = var.create ? 1 : 0

  name = "${var.prefix}-${var.identifier}-${var.environment}-cluster"

  dynamic "setting" {
    for_each = [var.cluster_settings]

    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Name        = "${var.prefix}-${var.identifier}-${var.environment}-cluster"
    }
  )
}

################################################################################
# Cluster Capacity Providers
################################################################################

locals {
  default_capacity_providers = merge(
    { for k, v in var.fargate_capacity_providers : k => v if var.default_capacity_provider_use_fargate },
    { for k, v in var.autoscaling_capacity_providers : k => v if !var.default_capacity_provider_use_fargate }
  )
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count = var.create && length(merge(var.fargate_capacity_providers, var.autoscaling_capacity_providers)) > 0 ? 1 : 0

  cluster_name = aws_ecs_cluster.this[0].name
  capacity_providers = distinct(concat(
    [for k, v in var.fargate_capacity_providers : try(v.name, k)],
    [for k, v in var.autoscaling_capacity_providers : try(v.name, k)]
  ))

  dynamic "default_capacity_provider_strategy" {
    for_each = local.default_capacity_providers
    iterator = strategy

    content {
      capacity_provider = try(strategy.value.name, strategy.key)
      base              = try(strategy.value.default_capacity_provider_strategy.base, null)
      weight            = try(strategy.value.default_capacity_provider_strategy.weight, null)
    }
  }

  depends_on = [
    aws_ecs_capacity_provider.this
  ]
}

################################################################################
# Capacity Provider - Autoscaling Group(s)
################################################################################

resource "aws_ecs_capacity_provider" "this" {
  for_each = { for k, v in var.autoscaling_capacity_providers : k => v if var.create }

  name = try(each.value.name, each.key)

  auto_scaling_group_provider {
    auto_scaling_group_arn         = each.value.auto_scaling_group_arn
    managed_termination_protection = try(each.value.managed_termination_protection, null)

    dynamic "managed_scaling" {
      for_each = try([each.value.managed_scaling], [])

      content {
        instance_warmup_period    = try(managed_scaling.value.instance_warmup_period, null)
        maximum_scaling_step_size = try(managed_scaling.value.maximum_scaling_step_size, null)
        minimum_scaling_step_size = try(managed_scaling.value.minimum_scaling_step_size, null)
        status                    = try(managed_scaling.value.status, null)
        target_capacity           = try(managed_scaling.value.target_capacity, null)
      }
    }
  }

  tags = merge(var.tags,
    try(each.value.tags, {}),
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
    }
  )
}
