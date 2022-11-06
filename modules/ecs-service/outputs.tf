################################################################################
# ECS Service
################################################################################
output "ecs_service_name" {
  description = "The name of the created ECS service."
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "The ARN of the created ECS task definition."
  value       = aws_ecs_task_definition.this.arn
}

output "log_group" {
  description = "The name of the log group capturing all task output."
  value       = var.include_log_group == "yes" ? aws_cloudwatch_log_group.this[0].name : ""
}

output "security_group_id" {
  description = "The ID of the default security group associated with the network interfaces of the ECS tasks."
  value       = (var.associate_default_security_group == "yes" && var.service_task_network_mode == "awsvpc") ? aws_security_group.this.0.id : ""
}

output "ecs_service_cloudwatch_log_group_name" {
  description = "The name of the ecs service cloudwatch log group"
  value       = aws_cloudwatch_log_group.this[*].name
}