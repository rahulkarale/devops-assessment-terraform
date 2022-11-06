################################################################################
# Security group and rules for ESC service
################################################################################
resource "aws_security_group" "this" {
  count = (var.associate_default_security_group == "yes" && var.service_task_network_mode == "awsvpc") ? 1 : 0

  name        = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}-sg"
  description = "Container access for ecs service: ${var.service_name}"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name        = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}-sg"
    ServiceName = var.service_name
  })
}

resource "aws_security_group_rule" "cluster_default_ingress" {
  count = (var.associate_default_security_group == "yes" && var.include_default_ingress_rule == "yes" && var.service_task_network_mode == "awsvpc") ? 1 : 0

  type = "ingress"

  security_group_id = aws_security_group.this.0.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = var.default_security_group_ingress_cidrs
}

resource "aws_security_group_rule" "cluster_default_egress" {
  count = (var.associate_default_security_group == "yes" && var.include_default_egress_rule == "yes" && var.service_task_network_mode == "awsvpc") ? 1 : 0

  type = "egress"

  security_group_id = aws_security_group.this.0.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = var.default_security_group_egress_cidrs
}

################################################################################
# ESC service task definition
################################################################################

locals {
  service_task_container_definitions_template = coalesce(
    var.service_task_container_definitions,
  file("${path.module}/container-definitions/service.json.tpl"))
  service_task_container_definitions = replace(
    replace(
      replace(
        replace(
          replace(
            replace(
              replace(
                replace(
                  local.service_task_container_definitions_template,
                "$${name}", var.service_name),
              "$${image}", var.service_image),
            "$${cpu}", tonumber(var.service_cpu)),
          "$${memory}", tonumber(var.service_memory)),
        "$${command}", jsonencode(var.service_command)),
      "$${port}", var.service_port),
    "$${region}", var.region),
  "$${log_group}", var.include_log_group == "yes" ? aws_cloudwatch_log_group.this[0].name : "")
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}"
  container_definitions    = local.service_task_container_definitions
  requires_compatibilities = [var.service_launch_type]

  cpu    = var.task_cpu
  memory = var.task_memory

  network_mode = var.service_task_network_mode
  pid_mode     = var.service_task_pid_mode

  task_role_arn      = var.service_role
  execution_role_arn = var.execution_role_arn

  dynamic "volume" {
    for_each = var.service_volumes
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)
    }
  }

  tags = merge(var.tags, {
    Name = "${var.prefix}-${var.identifier}-${var.environment}-${var.service_name}"
  })
}

################################################################################
# AWS service discovery service
################################################################################

resource "aws_service_discovery_service" "service" {
  count = (var.register_in_service_discovery == "yes" && var.service_discovery_create_registry == "yes") ? 1 : 0

  name = var.service_name

  dns_config {
    namespace_id = var.service_discovery_namespace_id

    dns_records {
      ttl  = 10
      type = var.service_discovery_record_type
    }
  }

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Name        = var.service_name
    }
  )
}

################################################################################
# ESC service
################################################################################

resource "aws_ecs_service" "this" {
  name                               = var.service_name
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = var.service_desired_count
  iam_role                           = (var.attach_to_load_balancer == "yes" && var.service_task_network_mode != "awsvpc") ? var.ecs_cluster_service_role_arn : null
  launch_type                        = var.service_launch_type
  deployment_maximum_percent         = var.service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.service_deployment_minimum_healthy_percent

  health_check_grace_period_seconds = var.attach_to_load_balancer == "yes" ? var.service_health_check_grace_period_seconds : null

  scheduling_strategy = var.scheduling_strategy

  force_new_deployment = var.force_new_deployment == "yes"

  dynamic "network_configuration" {
    for_each = var.service_task_network_mode == "awsvpc" ? [var.subnet_ids] : []

    content {
      subnets         = network_configuration.value
      security_groups = [aws_security_group.this.0.id]
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints

    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }

  dynamic "service_registries" {
    for_each = var.register_in_service_discovery == "yes" ? [var.service_discovery_create_registry == "yes" ? aws_service_discovery_service.service[0].arn : var.service_discovery_registry_arn] : []

    content {
      registry_arn   = service_registries.value
      container_name = var.service_discovery_record_type == "SRV" ? coalesce(var.service_discovery_container_name, var.service_name) : null
      container_port = var.service_discovery_record_type == "SRV" ? coalesce(var.service_discovery_container_port, var.service_port) : null
    }
  }

  dynamic "load_balancer" {
    for_each = var.attach_to_load_balancer == "yes" ? [coalesce(var.target_group_arn, var.service_elb_name)] : []

    content {
      elb_name         = var.service_elb_name
      target_group_arn = var.target_group_arn
      container_name   = coalesce(var.target_container_name, var.service_name)
      container_port   = coalesce(var.target_port, var.service_port)
    }
  }

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Name        = var.service_name
    }
  )
}

################################################################################
# ESC service
################################################################################

resource "aws_cloudwatch_log_group" "this" {
  count = var.include_log_group == "yes" ? 1 : 0

  name              = "/${var.prefix}/${var.identifier}/${var.environment}/ecs-service/${var.service_name}"
  retention_in_days = var.log_group_retention

  tags = merge(var.tags,
    {
      Prefix      = var.prefix
      Identifier  = var.identifier
      Environment = var.environment
      Name        = var.service_name
    }
  )
}

