<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.38.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |
| <a name="module_ecs_load_balancer"></a> [ecs\_load\_balancer](#module\_ecs\_load\_balancer) | ./modules/ecs-service-elb | n/a |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | ./modules/ecs-service | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.task_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the  project | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier for the  project | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for the  project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ARN that identifies the cluster |
| <a name="output_cluster_autoscaling_capacity_providers"></a> [cluster\_autoscaling\_capacity\_providers](#output\_cluster\_autoscaling\_capacity\_providers) | Map of capacity providers created and their attributes |
| <a name="output_cluster_capacity_providers"></a> [cluster\_capacity\_providers](#output\_cluster\_capacity\_providers) | Map of cluster capacity providers attributes |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID that identifies the cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name that identifies the cluster |
| <a name="output_ecs_load_balancer_name"></a> [ecs\_load\_balancer\_name](#output\_ecs\_load\_balancer\_name) | ECS Load Balancer name |
| <a name="output_ecs_load_balancer_open_security_group"></a> [ecs\_load\_balancer\_open\_security\_group](#output\_ecs\_load\_balancer\_open\_security\_group) | ECS load balancer open security group |
| <a name="output_ecs_load_balancer_security_group"></a> [ecs\_load\_balancer\_security\_group](#output\_ecs\_load\_balancer\_security\_group) | ECS load balancer security group |
| <a name="output_ecs_load_balancer_target_group_arn"></a> [ecs\_load\_balancer\_target\_group\_arn](#output\_ecs\_load\_balancer\_target\_group\_arn) | ECS load balancer target group arn |
| <a name="output_ecs_service_cloudwatch_log_group"></a> [ecs\_service\_cloudwatch\_log\_group](#output\_ecs\_service\_cloudwatch\_log\_group) | ECS service cloudwatch log group name |
| <a name="output_ecs_service_log_group"></a> [ecs\_service\_log\_group](#output\_ecs\_service\_log\_group) | ECS service log group |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | ECS service name |
| <a name="output_ecs_service_security_group"></a> [ecs\_service\_security\_group](#output\_ecs\_service\_security\_group) | ECS service security group id |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | ECS Task Definition ARN |
<!-- END_TF_DOCS -->