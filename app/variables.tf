variable "tags" {
  type        = map(string)
  description = "Default tags to apply on all created resources"
  default     = {}
}

variable "environment" {
  default     = ""
  description = "Environment name"
}

variable "project" {
  type        = string
  description = "Account/Project Name"
}

variable "aws_region" {
  type        = string
  description = "Default AWS Region"
}

variable "aws_used_account_no" {
  type        = string
  description = "AWS Organization Account number used to assume role on"
}

variable "aws_azs" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"
}

variable "log_retention" {
  type        = number
  description = "How long should logs be retained"
  default     = 7
}

variable "rds_type" {
  type        = string
  description = "Valid values are `instance` and `cluster`"
  default     = "instance"
}

variable "aws_rds_instance_class" {
  type        = string
  description = "AWS instance class for RDS"
}

variable "aws_rds_allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrade for AWS RDS instance"
  default     = false
}

variable "aws_rds_apply_immediately" {
  type        = bool
  description = "Apply immediately upgrade for AWS RDS instance"
  default     = false
}

variable "aws_rds_performance_insights_enabled" {
  type        = bool
  description = "Enable performance insights for AWS RDS instance"
  default     = false
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "top_domain" {
  type        = string
  description = "DNS name of top domain"
}

variable "bastion_enabled" {
  type        = bool
  description = "Create bastion task"
  default     = false
}

variable "node_api_ecs_settings" {
  type = object({
    name                           = string
    gitlab_repo                    = string
    image_tag                      = string
    task_cpu                       = number
    task_memory                    = number
    min_capacity                   = number
    max_capacity                   = number
    cpu_utilization_high_threshold = number
    scale_up_adjustment            = number
    desired_count                  = number
  })
  description = "Task settings image tag, cpu, memory, autoscaling minimum capacity and maximum capacity, cpu utilization high threshold, scale up adjustment"
}

variable "ecs_task_exec_enabled" {
  type        = bool
  description = "If enabled you can directly interact with ECS containers"
  default     = false
}

variable "force_new_deployment" {
  type        = bool
  description = "Enable to force a new task deployment of the service."
  default     = false
}

variable "frontend_app_name" {
  type        = string
  description = "Front end application name"
}

variable "public_resources_name" {
  type        = string
  description = "Front end application name"
}

variable "bigquery_dataset" {
  type    = string
  default = ""
}

variable "frontend_gitlab_repo" {
  type        = string
  description = "CMS application gitlab path"
}

variable "aws_ses_region" {
  type        = string
  description = "AWS Region for SES"
}
