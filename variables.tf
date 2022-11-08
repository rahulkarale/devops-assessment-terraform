
################################################################################
# Variables
################################################################################

variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
}

variable "prefix" {
  description = "The prefix for the  project"
  type        = string
}

variable "identifier" {
  description = "The identifier for the  project"
  type        = string
}

variable "environment" {
  description = "The environment for the  project"
  type        = string
}

variable "include_log_group" {
  description = "The environment for CloudWatch resource"
  type        = string
}