<!-- BEGIN_TF_DOCS -->
# ECS CLUSTER LOAD BALANCER MODULE

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.front_end](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_security_group.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.open_to_load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_bucket"></a> [access\_logs\_bucket](#input\_access\_logs\_bucket) | Bucket for access logs | `string` | `""` | no |
| <a name="input_access_logs_bucket_prefix"></a> [access\_logs\_bucket\_prefix](#input\_access\_logs\_bucket\_prefix) | Prefix for access logs bucket | `string` | `""` | no |
| <a name="input_access_logs_interval"></a> [access\_logs\_interval](#input\_access\_logs\_interval) | Access log interval in seconds | `number` | `60` | no |
| <a name="input_allow_cidrs"></a> [allow\_cidrs](#input\_allow\_cidrs) | A list of CIDRs from which the ELB is reachable. | `list(string)` | n/a | yes |
| <a name="input_egress_cidrs"></a> [egress\_cidrs](#input\_egress\_cidrs) | A list of CIDRs which the ELB can reach. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment, like dev, test, prod etc | `string` | n/a | yes |
| <a name="input_expose_to_public_internet"></a> [expose\_to\_public\_internet](#input\_expose\_to\_public\_internet) | Whether or not the ELB is publicly accessible ("yes" or "no"). | `string` | `"no"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The target to use for health checks. | `string` | `"/"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region into which to deploy the load balancer. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service for which the ELB is being created. | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | The port on which the service containers are listening. | `string` | n/a | yes |
| <a name="input_store_access_logs"></a> [store\_access\_logs](#input\_store\_access\_logs) | Whether or not access logs of the ELB should be stored. | `string` | `"no"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The IDs of the subnets for the ELB to deploy into. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC into which to deploy the load balancer. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elb_name"></a> [elb\_name](#output\_elb\_name) | The name of the created ELB. |
| <a name="output_open_to_load_balancer_security_group_id"></a> [open\_to\_load\_balancer\_security\_group\_id](#output\_open\_to\_load\_balancer\_security\_group\_id) | The ID of the security group allowing access from the ELB. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group associated with the ELB. |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The target group arn. |
<!-- END_TF_DOCS -->