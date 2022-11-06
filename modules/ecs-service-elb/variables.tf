################################################################################
# Generic
################################################################################

variable "prefix" {
  description = "The prefix"
}

variable "identifier" {
  description = "The identifier"
  type        = string
}
variable "environment" {
  description = "Name of the environment, like dev, test, prod etc"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "The region into which to deploy the load balancer."
  type        = string
}


################################################################################
# AWS ELB for ECS
################################################################################

variable "vpc_id" {
  description = "The ID of the VPC into which to deploy the load balancer."
  type        = string
}
variable "subnet_ids" {
  description = "The IDs of the subnets for the ELB to deploy into."
  type        = list(string)
}

variable "service_name" {
  description = "The name of the service for which the ELB is being created."
  type        = string
}
variable "service_port" {
  description = "The port on which the service containers are listening."
  type        = string
}

variable "health_check_path" {
  description = "The target to use for health checks."
  type        = string
  default     = "/"
}
variable "allow_cidrs" {
  description = "A list of CIDRs from which the ELB is reachable."
  type        = list(string)
}

variable "egress_cidrs" {
  description = "A list of CIDRs which the ELB can reach."
  type        = list(string)
  default     = []
}

variable "expose_to_public_internet" {
  description = "Whether or not the ELB is publicly accessible (\"yes\" or \"no\")."
  type        = string
  default     = "no"
}

variable "access_logs_bucket" {
  description = "Bucket for access logs"
  type        = string
  default     = ""
}
variable "access_logs_bucket_prefix" {
  description = "Prefix for access logs bucket"
  type        = string
  default     = ""
}
variable "access_logs_interval" {
  description = "Access log interval in seconds"
  type        = number
  default     = 60
}

variable "store_access_logs" {
  description = "Whether or not access logs of the ELB should be stored."
  type        = string
  default     = "no"
}