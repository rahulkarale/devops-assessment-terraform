################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "ARN that identifies the cluster"
  value       = module.ecs.cluster_arn
}

output "cluster_id" {
  description = "ID that identifies the cluster"
  value       = module.ecs.cluster_id
}

output "cluster_name" {
  description = "Name that identifies the cluster"
  value       = module.ecs.cluster_name
}

################################################################################
# Cluster Capacity Providers
################################################################################

output "cluster_capacity_providers" {
  description = "Map of cluster capacity providers attributes"
  value       = module.ecs.cluster_capacity_providers
}

################################################################################
# Capacity Provider
################################################################################

output "cluster_autoscaling_capacity_providers" {
  description = "Map of capacity providers created and their attributes"
  value       = module.ecs.autoscaling_capacity_providers
}
################################################################################
# ECS Load balancer
################################################################################
output "ecs_load_balancer_name" {
  description = "ECS Load Balancer name"
  value       = module.ecs_load_balancer.elb_name
}

output "ecs_load_balancer_target_group_arn" {
  description = "ECS load balancer target group arn"
  value       = module.ecs_load_balancer.target_group_arn
}

output "ecs_load_balancer_open_security_group" {
  description = "ECS load balancer open security group"
  value       = module.ecs_load_balancer.open_to_load_balancer_security_group_id
}

output "ecs_load_balancer_security_group" {
  description = "ECS load balancer security group"
  value       = module.ecs_load_balancer.security_group_id
}

################################################################################
# Task Definition
################################################################################
output "ecs_task_definition_arn" {
  description = "ECS Task Definition ARN"
  value       = module.ecs_service.task_definition_arn
}

################################################################################
# ECS Service
################################################################################

output "ecs_service_security_group" {
  description = "ECS service security group id"
  value       = module.ecs_service.security_group_id
}

output "ecs_service_cloudwatch_log_group" {
  description = "ECS service cloudwatch log group name"
  value       = module.ecs_service.ecs_service_cloudwatch_log_group_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs_service.ecs_service_name
}

output "ecs_service_log_group" {
  description = "ECS service log group"
  value       = module.ecs_service.log_group
}
