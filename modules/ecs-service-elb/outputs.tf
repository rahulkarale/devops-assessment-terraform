output "elb_name" {
  description = "The name of the created ELB."
  value       = aws_lb.this.name
}

output "target_group_arn" {
  description = "The target group arn."
  value       = aws_alb_target_group.this.arn
}

output "security_group_id" {
  description = "The ID of the security group associated with the ELB."
  value       = aws_security_group.load_balancer.id
}

output "open_to_load_balancer_security_group_id" {
  description = "The ID of the security group allowing access from the ELB."
  value       = aws_security_group.open_to_load_balancer.id
}