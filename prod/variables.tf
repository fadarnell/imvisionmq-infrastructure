variable "tags" {
  type        = map(string)
  description = "Default tags to apply on all created resources"
  default     = {}
}

variable "environment" {
  type        = string
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

variable "aws_used_role_name" {
  type        = string
  description = "AWS IAM role to assume"
}

variable "authentication_account_no" {
  type        = string
  description = "Number of AWS Organization Account used to manage IAM users"
}

variable "aws_azs" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"
}

variable "force_new_deployment" {
  type        = bool
  description = "Enable to force a new task deployment of the service."
  default     = false
}

variable "top_domain" {
  type        = string
  description = "DNS name of top domain"
}

variable "aws_ses_region" {
  type        = string
  description = "AWS Region for SES"
}