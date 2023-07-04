variable "environment" {
  type        = string
  default     = ""
  description = "Environment name"
}

variable "project" {
  type        = string
  description = "Account/Project Name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply on repository"
}

variable "task_cpu" {
  type        = number
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 256
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 512
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources are created"
}

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "ecs_cluster_name" {
  type        = string
  description = "The Name of the ECS cluster where service will be provisioned. Required for alarms."
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to allow in Service `network_configuration`"
  type        = list(string)
}

variable "alb_arn_suffix" {
  type = string
}

variable "ingress_priority" {
  type = string
}

variable "listener_arns" {
  type = list(string)
}

variable "host" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

variable "ci_cd_username" {
  type = string
}

variable "assign_public_ip" {
  type    = bool
  default = false
}