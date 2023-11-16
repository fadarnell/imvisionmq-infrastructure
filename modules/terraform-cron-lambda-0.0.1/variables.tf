variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "name" {
  type        = string
  default     = "app"
  description = "Solution name, e.g. 'app' or 'cluster'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "log_retention" {
  type        = number
  default     = 7
  description = "Specifies the number of days you want to retain log events in the specified log group."
}

variable "schedule_expression" {
  type        = string
  default     = "cron(0 1 1/1 * ? *)"
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
}

variable "vpc_mode_enable" {
  type        = bool
  description = "Set to true to enable usage of lambda in VPC"
  default     = false
}

variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = {
    security_group_ids = []
    subnet_ids         = []
  }
  description = "Specify a list of security groups and subnets in the VPC to use in lambda configuration"
}

variable "path_to_lambda_dir" {
  type        = string
  description = "Path to lambda function dir"
  default     = "lambda"
}

variable "env_variables" {
  type        = map(string)
  description = "Function eenv variables"
  default = {}
}

variable "timeout" {
  type        = number
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = 60
}

variable "memory_size" {
  type        = number
  description = "The amount of memory, in MB, your Lambda Function is given."
  default     = 128
}
