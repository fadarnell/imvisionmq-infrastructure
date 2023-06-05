variable "environment" {
  default     = ""
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Resource common name"
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

variable "hosts" {
  type        = list(string)
  default     = []
  description = "Unauthenticated hosts to match in Hosts header"
}

variable "paths" {
  type        = list(string)
  default     = []
  description = "Unauthenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources are created"
}

variable "target_type" {
  type        = string
  default     = "ip"
  description = "The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group"
}

variable "default_target_group_enabled" {
  type        = bool
  default     = true
  description = "Enable/disable creation of the default target group"
}

variable "target_group_arn" {
  type        = string
  default     = ""
  description = "Existing ALB target group ARN. If provided, set `default_target_group_enabled` to `false` to disable creation of the default target group"
}

variable "deregistration_delay" {
  type        = number
  default     = 15
  description = "The amount of time to wait in seconds while deregistering target"
}

variable "listener_arns" {
  type        = list(string)
  default     = []
  description = "A list of unauthenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "priority" {
  type        = number
  default     = 100
  description = "The priority for the rules without authentication, between 1 and 50000 (1 being highest priority). Must be different from `authenticated_priority` since a listener can't have multiple rules with the same priority"
}

variable "port" {
  type        = number
  default     = 80
  description = "The port for generated ALB target group (if target_group_arn not set)"
}

variable "protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol for generated ALB target group (if target_group_arn not set)"
}

variable "health_check_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether health checks are enabled. Defaults to `true`"
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The destination for the health check request"
}

variable "health_check_port" {
  type        = string
  default     = "traffic-port"
  description = "The port to use to connect with the target. Valid values are either ports 1-65536, or `traffic-port`. Defaults to `traffic-port`"
}

variable "health_check_protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol to use to connect with the target. Defaults to `HTTP`. Not applicable when `target_type` is `lambda`"
}

variable "health_check_timeout" {
  type        = number
  default     = 10
  description = "The amount of time to wait in seconds before failing a health check request"
}

variable "health_check_healthy_threshold" {
  type        = number
  default     = 2
  description = "The number of consecutive health checks successes required before healthy"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "The number of consecutive health check failures required before unhealthy"
}

variable "health_check_interval" {
  type        = number
  default     = 15
  description = "The duration in seconds in between health checks"
}

variable "health_check_matcher" {
  type        = string
  default     = "200-399"
  description = "The HTTP response codes to indicate a healthy check"
}

variable "alb_arn_suffix" {
  type        = string
  description = "ARN suffix of the ALB for the Target Group. Required for alarms."
  default     = ""
}

variable "slow_start" {
  type        = number
  default     = 0
  description = "The amount of time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is `0` seconds"
}

variable "stickiness_type" {
  type        = string
  default     = "lb_cookie"
  description = "The type of sticky sessions. The only current possible value is `lb_cookie`"
}

variable "stickiness_cookie_duration" {
  type        = number
  default     = 86400
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds)"
}

variable "stickiness_enabled" {
  type        = bool
  default     = false
  description = "Boolean to enable / disable `stickiness`. Default is `true`"
}

variable "authenticated_listener_arns" {
  type        = list(string)
  default     = []
  description = "A list of authenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "authenticated_priority" {
  type        = number
  default     = 300
  description = "The priority for the rules with authentication, between 1 and 50000 (1 being highest priority). Must be different from `priority` since a listener can't have multiple rules with the same priority"
}

variable "authenticated_hosts" {
  type        = list(string)
  default     = []
  description = "Authenticated hosts to match in Hosts header"
}

variable "authenticated_paths" {
  type        = list(string)
  default     = []
  description = "Authenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "authentication_type" {
  type        = string
  default     = ""
  description = "Authentication type. Supported values are `COGNITO` and `OIDC`"
}

variable "authentication_cognito_user_pool_arn" {
  type        = string
  description = "Cognito User Pool ARN"
  default     = ""
}

variable "authentication_cognito_user_pool_client_id" {
  type        = string
  description = "Cognito User Pool Client ID"
  default     = ""
}

variable "authentication_cognito_user_pool_domain" {
  type        = string
  description = "Cognito User Pool Domain. The User Pool Domain should be set to the domain prefix (`xxx`) instead of full domain (https://xxx.auth.us-west-2.amazoncognito.com)"
  default     = ""
}

variable "authentication_oidc_client_id" {
  type        = string
  description = "OIDC Client ID"
  default     = ""
}

variable "authentication_oidc_client_secret" {
  type        = string
  description = "OIDC Client Secret"
  default     = ""
}

variable "authentication_oidc_issuer" {
  type        = string
  description = "OIDC Issuer"
  default     = ""
}

variable "authentication_oidc_authorization_endpoint" {
  type        = string
  description = "OIDC Authorization Endpoint"
  default     = ""
}

variable "authentication_oidc_token_endpoint" {
  type        = string
  description = "OIDC Token Endpoint"
  default     = ""
}

variable "authentication_oidc_user_info_endpoint" {
  type        = string
  description = "OIDC User Info Endpoint"
  default     = ""
}

##########
# ALARMS
##########

variable "alb_target_group_alarms_enabled" {
  type        = bool
  description = "A boolean to enable/disable CloudWatch Alarms for ALB Target metrics"
  default     = false
}

variable "alb_target_group_alarms_3xx_threshold" {
  type        = number
  description = "The maximum number of 3XX HTTPCodes in a given period for ECS Service"
  default     = 25
}

variable "alb_target_group_alarms_4xx_threshold" {
  type        = number
  description = "The maximum number of 4XX HTTPCodes in a given period for ECS Service"
  default     = 25
}

variable "alb_target_group_alarms_5xx_threshold" {
  type        = number
  description = "The maximum number of 5XX HTTPCodes in a given period for ECS Service"
  default     = 25
}

variable "alb_target_group_alarms_period" {
  type        = number
  description = "The period (in seconds) to analyze for ALB CloudWatch Alarms"
  default     = 300
}

variable "alb_target_group_alarms_evaluation_periods" {
  type        = number
  description = "The number of periods to analyze for ALB CloudWatch Alarms"
  default     = 1
}

variable "alb_target_group_alarms_alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an ALARM state from any other state"
  default     = [""]
}

variable "alb_target_group_alarms_ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an OK state from any other state"
  default     = [""]
}

variable "alb_target_group_alarms_insufficient_data_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an INSUFFICIENT_DATA state from any other state"
  default     = [""]
}

variable "alb_target_group_alarms_treat_missing_data" {
  type        = string
  description = "Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching."
  default     = "missing"
}

variable "alb_target_group_alarms_notify_arns" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient_data}_actions variable. "
  default     = [""]
}

variable "alb_target_group_alarms_httpcode_alarm_description" {
  type        = string
  description = "The string to format and use as the httpcode alarm description"
  default     = "HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"
}

variable "alb_target_group_alarms_response_time_threshold" {
  type        = number
  description = "The maximum average target response time (in seconds) over a period. A negative value will disable the alert"
  default     = 0.5
}

variable "alb_target_group_alarms_response_time_alarm_description" {
  type        = string
  description = "The string to format and use as the target response time alarm description"
  default     = "Target Response Time average for %v over %v last %d minute(s) over %v period(s)"
}

variable "alb_target_group_alarms_elb_5xx_count_threshold" {
  type        = number
  description = "The maximum count of ELB 5XX requests over a period. A negative value will disable the alert"
  default     = -1
}
