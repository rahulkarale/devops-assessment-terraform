<!-- BEGIN_TF_DOCS -->
# ECS SERVICE MODULE

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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cluster_default_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_default_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_service_discovery_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associate_default_security_group"></a> [associate\_default\_security\_group](#input\_associate\_default\_security\_group) | Whether or not to create and associate a default security group for the tasks created by this service ("yes" or "no"). Defaults to "yes". Only applicable when service\_task\_network\_mode is "awsvpc". | `string` | `"yes"` | no |
| <a name="input_attach_to_load_balancer"></a> [attach\_to\_load\_balancer](#input\_attach\_to\_load\_balancer) | Whether or not this service should attach to a load balancer ("yes" or "no"). | `string` | `"yes"` | no |
| <a name="input_default_security_group_egress_cidrs"></a> [default\_security\_group\_egress\_cidrs](#input\_default\_security\_group\_egress\_cidrs) | The CIDRs accessible from containers when using the default security group. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_default_security_group_ingress_cidrs"></a> [default\_security\_group\_ingress\_cidrs](#input\_default\_security\_group\_ingress\_cidrs) | The CIDRs allowed access to containers when using the default security group. | `list(string)` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | The ID of the ECS cluster in which to deploy the service. | `string` | n/a | yes |
| <a name="input_ecs_cluster_service_role_arn"></a> [ecs\_cluster\_service\_role\_arn](#input\_ecs\_cluster\_service\_role\_arn) | The ARN of the IAM role to provide to ECS to manage the service. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment, like dev, test, prod etc | `string` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string` | `""` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Whether or not to force a new deployment of the service ("yes" or "no"). Defaults to "no". | `string` | `"no"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier | `string` | n/a | yes |
| <a name="input_include_default_egress_rule"></a> [include\_default\_egress\_rule](#input\_include\_default\_egress\_rule) | Whether or not to include the default egress rule in the default security group for the tasks created by this service ("yes" or "no"). Defaults to "yes". Only applicable when service\_task\_network\_mode is "awsvpc". | `string` | `"yes"` | no |
| <a name="input_include_default_ingress_rule"></a> [include\_default\_ingress\_rule](#input\_include\_default\_ingress\_rule) | Whether or not to include the default ingress rule in the default security group for the tasks created by this service ("yes" or "no"). Defaults to "yes". Only applicable when service\_task\_network\_mode is "awsvpc". | `string` | `"yes"` | no |
| <a name="input_include_log_group"></a> [include\_log\_group](#input\_include\_log\_group) | Whether or not to create a log group for the service ("yes" or "no"). Defaults to "yes". | `string` | `"yes"` | no |
| <a name="input_log_group_retention"></a> [log\_group\_retention](#input\_log\_group\_retention) | The number of days you want to retain log events. See cloudwatch\_log\_group for possible values. Defaults to 0 (forever). | `number` | `0` | no |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | A list of placement constraints for the service. | `list(map(string))` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region into which to deploy the service. | `string` | n/a | yes |
| <a name="input_register_in_service_discovery"></a> [register\_in\_service\_discovery](#input\_register\_in\_service\_discovery) | Whether or not this service should be registered in service discovery ("yes" or "no"). | `string` | `"no"` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | The scheduling strategy to use for this service ("REPLICA" or "DAEMON"). | `string` | `"REPLICA"` | no |
| <a name="input_service_command"></a> [service\_command](#input\_service\_command) | The command to run to start the container. | `list(string)` | `[]` | no |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | CPU required to run the service in container | `number` | `10` | no |
| <a name="input_service_deployment_maximum_percent"></a> [service\_deployment\_maximum\_percent](#input\_service\_deployment\_maximum\_percent) | The maximum percentage of the desired count that can be running. | `number` | `200` | no |
| <a name="input_service_deployment_minimum_healthy_percent"></a> [service\_deployment\_minimum\_healthy\_percent](#input\_service\_deployment\_minimum\_healthy\_percent) | The minimum healthy percentage of the desired count to keep running. | `number` | `50` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | The desired number of tasks in the service. | `number` | `3` | no |
| <a name="input_service_discovery_container_name"></a> [service\_discovery\_container\_name](#input\_service\_discovery\_container\_name) | The container name to use when registering the service in service discovery. Defaults to the service name. | `string` | `""` | no |
| <a name="input_service_discovery_container_port"></a> [service\_discovery\_container\_port](#input\_service\_discovery\_container\_port) | The container port to use when registering the service in service discovery. Defaults to the service port. | `string` | `""` | no |
| <a name="input_service_discovery_create_registry"></a> [service\_discovery\_create\_registry](#input\_service\_discovery\_create\_registry) | Whether or not to create a service discovery registry for this service ("yes" or "no"). | `string` | `"yes"` | no |
| <a name="input_service_discovery_namespace_id"></a> [service\_discovery\_namespace\_id](#input\_service\_discovery\_namespace\_id) | The ID of the service discovery namespace in which to create the service discovery registry. Required if service\_discovery\_create\_registry is "yes". | `string` | `""` | no |
| <a name="input_service_discovery_record_type"></a> [service\_discovery\_record\_type](#input\_service\_discovery\_record\_type) | The type of record to create when registering the service in service discovery. | `string` | `"SRV"` | no |
| <a name="input_service_discovery_registry_arn"></a> [service\_discovery\_registry\_arn](#input\_service\_discovery\_registry\_arn) | The ARN of the service discovery registry into which to register the service. Required if service\_discovery\_create\_registry is "no". | `string` | `""` | no |
| <a name="input_service_elb_name"></a> [service\_elb\_name](#input\_service\_elb\_name) | The name of the ELB to configure to point at the service containers. | `string` | `""` | no |
| <a name="input_service_health_check_grace_period_seconds"></a> [service\_health\_check\_grace\_period\_seconds](#input\_service\_health\_check\_grace\_period\_seconds) | The number of seconds to wait for the service to start up before starting load balancer health checks. | `number` | `0` | no |
| <a name="input_service_image"></a> [service\_image](#input\_service\_image) | The docker image (including version) to deploy. | `string` | `""` | no |
| <a name="input_service_launch_type"></a> [service\_launch\_type](#input\_service\_launch\_type) | Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2 | `string` | `"EC2"` | no |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | Memory required to run the service inn containe | `number` | `256` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service being created. | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | The port the containers will be listening on. | `string` | `""` | no |
| <a name="input_service_role"></a> [service\_role](#input\_service\_role) | The ARN of the service task role to use. | `string` | `""` | no |
| <a name="input_service_task_container_definitions"></a> [service\_task\_container\_definitions](#input\_service\_task\_container\_definitions) | A template for the container definitions in the task. | `string` | `""` | no |
| <a name="input_service_task_network_mode"></a> [service\_task\_network\_mode](#input\_service\_task\_network\_mode) | The network mode used for the containers in the task. | `string` | `"awsvpc"` | no |
| <a name="input_service_task_pid_mode"></a> [service\_task\_pid\_mode](#input\_service\_task\_pid\_mode) | The process namespace used for the containers in the task. | `string` | `null` | no |
| <a name="input_service_volumes"></a> [service\_volumes](#input\_service\_volumes) | A list of volumes to make available to the containers in the service. | `list(map(string))` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The IDs of the subnets in which to create ENIs when the service task network mode is "awsvpc". | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_target_container_name"></a> [target\_container\_name](#input\_target\_container\_name) | The name of the container to which the load balancer should route traffic. Defaults to the service\_name. | `string` | `""` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The arn of the target group to point at the service containers. | `string` | `""` | no |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | The port to which the load balancer should route traffic. Defaults to the service\_port. | `string` | `""` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | CPU required for the service task | `number` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Memory required for the service task | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC into which to deploy the service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_cloudwatch_log_group_name"></a> [ecs\_service\_cloudwatch\_log\_group\_name](#output\_ecs\_service\_cloudwatch\_log\_group\_name) | The name of the ecs service cloudwatch log group |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The name of the created ECS service. |
| <a name="output_log_group"></a> [log\_group](#output\_log\_group) | The name of the log group capturing all task output. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the default security group associated with the network interfaces of the ECS tasks. |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | The ARN of the created ECS task definition. |
<!-- END_TF_DOCS -->