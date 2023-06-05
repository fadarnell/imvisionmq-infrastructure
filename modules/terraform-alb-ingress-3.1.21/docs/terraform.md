<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb-ingress"></a> [alb-ingress](#module\_alb-ingress) | git::https://github.com/cloudposse/terraform-aws-alb-ingress | 0.24.2 |
| <a name="module_alb-target-group-alarms"></a> [alb-target-group-alarms](#module\_alb-target-group-alarms) | git::https://github.com/cloudposse/terraform-aws-alb-target-group-cloudwatch-sns-alarms.git | 0.16.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn_suffix"></a> [alb\_arn\_suffix](#input\_alb\_arn\_suffix) | ARN suffix of the ALB for the Target Group. Required for alarms. | `string` | `""` | no |
| <a name="input_alb_target_group_alarms_3xx_threshold"></a> [alb\_target\_group\_alarms\_3xx\_threshold](#input\_alb\_target\_group\_alarms\_3xx\_threshold) | The maximum number of 3XX HTTPCodes in a given period for ECS Service | `number` | `25` | no |
| <a name="input_alb_target_group_alarms_4xx_threshold"></a> [alb\_target\_group\_alarms\_4xx\_threshold](#input\_alb\_target\_group\_alarms\_4xx\_threshold) | The maximum number of 4XX HTTPCodes in a given period for ECS Service | `number` | `25` | no |
| <a name="input_alb_target_group_alarms_5xx_threshold"></a> [alb\_target\_group\_alarms\_5xx\_threshold](#input\_alb\_target\_group\_alarms\_5xx\_threshold) | The maximum number of 5XX HTTPCodes in a given period for ECS Service | `number` | `25` | no |
| <a name="input_alb_target_group_alarms_alarm_actions"></a> [alb\_target\_group\_alarms\_alarm\_actions](#input\_alb\_target\_group\_alarms\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an ALARM state from any other state | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_alb_target_group_alarms_elb_5xx_count_threshold"></a> [alb\_target\_group\_alarms\_elb\_5xx\_count\_threshold](#input\_alb\_target\_group\_alarms\_elb\_5xx\_count\_threshold) | The maximum count of ELB 5XX requests over a period. A negative value will disable the alert | `number` | `-1` | no |
| <a name="input_alb_target_group_alarms_enabled"></a> [alb\_target\_group\_alarms\_enabled](#input\_alb\_target\_group\_alarms\_enabled) | A boolean to enable/disable CloudWatch Alarms for ALB Target metrics | `bool` | `false` | no |
| <a name="input_alb_target_group_alarms_evaluation_periods"></a> [alb\_target\_group\_alarms\_evaluation\_periods](#input\_alb\_target\_group\_alarms\_evaluation\_periods) | The number of periods to analyze for ALB CloudWatch Alarms | `number` | `1` | no |
| <a name="input_alb_target_group_alarms_httpcode_alarm_description"></a> [alb\_target\_group\_alarms\_httpcode\_alarm\_description](#input\_alb\_target\_group\_alarms\_httpcode\_alarm\_description) | The string to format and use as the httpcode alarm description | `string` | `"HTTPCode %v count for %v over %v last %d minute(s) over %v period(s)"` | no |
| <a name="input_alb_target_group_alarms_insufficient_data_actions"></a> [alb\_target\_group\_alarms\_insufficient\_data\_actions](#input\_alb\_target\_group\_alarms\_insufficient\_data\_actions) | A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an INSUFFICIENT\_DATA state from any other state | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_alb_target_group_alarms_notify_arns"></a> [alb\_target\_group\_alarms\_notify\_arns](#input\_alb\_target\_group\_alarms\_notify\_arns) | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient\_data}\_actions variable. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_alb_target_group_alarms_ok_actions"></a> [alb\_target\_group\_alarms\_ok\_actions](#input\_alb\_target\_group\_alarms\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to execute when ALB Target Group alarms transition into an OK state from any other state | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_alb_target_group_alarms_period"></a> [alb\_target\_group\_alarms\_period](#input\_alb\_target\_group\_alarms\_period) | The period (in seconds) to analyze for ALB CloudWatch Alarms | `number` | `300` | no |
| <a name="input_alb_target_group_alarms_response_time_alarm_description"></a> [alb\_target\_group\_alarms\_response\_time\_alarm\_description](#input\_alb\_target\_group\_alarms\_response\_time\_alarm\_description) | The string to format and use as the target response time alarm description | `string` | `"Target Response Time average for %v over %v last %d minute(s) over %v period(s)"` | no |
| <a name="input_alb_target_group_alarms_response_time_threshold"></a> [alb\_target\_group\_alarms\_response\_time\_threshold](#input\_alb\_target\_group\_alarms\_response\_time\_threshold) | The maximum average target response time (in seconds) over a period. A negative value will disable the alert | `number` | `0.5` | no |
| <a name="input_alb_target_group_alarms_treat_missing_data"></a> [alb\_target\_group\_alarms\_treat\_missing\_data](#input\_alb\_target\_group\_alarms\_treat\_missing\_data) | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching. | `string` | `"missing"` | no |
| <a name="input_authenticated_hosts"></a> [authenticated\_hosts](#input\_authenticated\_hosts) | Authenticated hosts to match in Hosts header | `list(string)` | `[]` | no |
| <a name="input_authenticated_listener_arns"></a> [authenticated\_listener\_arns](#input\_authenticated\_listener\_arns) | A list of authenticated ALB listener ARNs to attach ALB listener rules to | `list(string)` | `[]` | no |
| <a name="input_authenticated_paths"></a> [authenticated\_paths](#input\_authenticated\_paths) | Authenticated path pattern to match (a maximum of 1 can be defined) | `list(string)` | `[]` | no |
| <a name="input_authenticated_priority"></a> [authenticated\_priority](#input\_authenticated\_priority) | The priority for the rules with authentication, between 1 and 50000 (1 being highest priority). Must be different from `priority` since a listener can't have multiple rules with the same priority | `number` | `300` | no |
| <a name="input_authentication_cognito_user_pool_arn"></a> [authentication\_cognito\_user\_pool\_arn](#input\_authentication\_cognito\_user\_pool\_arn) | Cognito User Pool ARN | `string` | `""` | no |
| <a name="input_authentication_cognito_user_pool_client_id"></a> [authentication\_cognito\_user\_pool\_client\_id](#input\_authentication\_cognito\_user\_pool\_client\_id) | Cognito User Pool Client ID | `string` | `""` | no |
| <a name="input_authentication_cognito_user_pool_domain"></a> [authentication\_cognito\_user\_pool\_domain](#input\_authentication\_cognito\_user\_pool\_domain) | Cognito User Pool Domain. The User Pool Domain should be set to the domain prefix (`xxx`) instead of full domain (https://xxx.auth.us-west-2.amazoncognito.com) | `string` | `""` | no |
| <a name="input_authentication_oidc_authorization_endpoint"></a> [authentication\_oidc\_authorization\_endpoint](#input\_authentication\_oidc\_authorization\_endpoint) | OIDC Authorization Endpoint | `string` | `""` | no |
| <a name="input_authentication_oidc_client_id"></a> [authentication\_oidc\_client\_id](#input\_authentication\_oidc\_client\_id) | OIDC Client ID | `string` | `""` | no |
| <a name="input_authentication_oidc_client_secret"></a> [authentication\_oidc\_client\_secret](#input\_authentication\_oidc\_client\_secret) | OIDC Client Secret | `string` | `""` | no |
| <a name="input_authentication_oidc_issuer"></a> [authentication\_oidc\_issuer](#input\_authentication\_oidc\_issuer) | OIDC Issuer | `string` | `""` | no |
| <a name="input_authentication_oidc_token_endpoint"></a> [authentication\_oidc\_token\_endpoint](#input\_authentication\_oidc\_token\_endpoint) | OIDC Token Endpoint | `string` | `""` | no |
| <a name="input_authentication_oidc_user_info_endpoint"></a> [authentication\_oidc\_user\_info\_endpoint](#input\_authentication\_oidc\_user\_info\_endpoint) | OIDC User Info Endpoint | `string` | `""` | no |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | Authentication type. Supported values are `COGNITO` and `OIDC` | `string` | `""` | no |
| <a name="input_default_target_group_enabled"></a> [default\_target\_group\_enabled](#input\_default\_target\_group\_enabled) | Enable/disable creation of the default target group | `bool` | `true` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time to wait in seconds while deregistering target | `number` | `15` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `""` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | Indicates whether health checks are enabled. Defaults to `true` | `bool` | `true` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | The number of consecutive health checks successes required before healthy | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The duration in seconds in between health checks | `number` | `15` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | The HTTP response codes to indicate a healthy check | `string` | `"200-399"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination for the health check request | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port to use to connect with the target. Valid values are either ports 1-65536, or `traffic-port`. Defaults to `traffic-port` | `string` | `"traffic-port"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol to use to connect with the target. Defaults to `HTTP`. Not applicable when `target_type` is `lambda` | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The amount of time to wait in seconds before failing a health check request | `number` | `10` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | The number of consecutive health check failures required before unhealthy | `number` | `2` | no |
| <a name="input_hosts"></a> [hosts](#input\_hosts) | Unauthenticated hosts to match in Hosts header | `list(string)` | `[]` | no |
| <a name="input_listener_arns"></a> [listener\_arns](#input\_listener\_arns) | A list of unauthenticated ALB listener ARNs to attach ALB listener rules to | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource common name | `string` | n/a | yes |
| <a name="input_paths"></a> [paths](#input\_paths) | Unauthenticated path pattern to match (a maximum of 1 can be defined) | `list(string)` | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | The port for generated ALB target group (if target\_group\_arn not set) | `number` | `80` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority for the rules without authentication, between 1 and 50000 (1 being highest priority). Must be different from `authenticated_priority` since a listener can't have multiple rules with the same priority | `number` | `100` | no |
| <a name="input_project"></a> [project](#input\_project) | Account/Project Name | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol for generated ALB target group (if target\_group\_arn not set) | `string` | `"HTTP"` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | The amount of time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is `0` seconds | `number` | `0` | no |
| <a name="input_stickiness_cookie_duration"></a> [stickiness\_cookie\_duration](#input\_stickiness\_cookie\_duration) | The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds) | `number` | `86400` | no |
| <a name="input_stickiness_enabled"></a> [stickiness\_enabled](#input\_stickiness\_enabled) | Boolean to enable / disable `stickiness`. Default is `true` | `bool` | `false` | no |
| <a name="input_stickiness_type"></a> [stickiness\_type](#input\_stickiness\_type) | The type of sticky sessions. The only current possible value is `lb_cookie` | `string` | `"lb_cookie"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on repository | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | Existing ALB target group ARN. If provided, set `default_target_group_enabled` to `false` to disable creation of the default target group | `string` | `""` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group | `string` | `"ip"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources are created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | ALB Target group ARN |
| <a name="output_target_group_arn_suffix"></a> [target\_group\_arn\_suffix](#output\_target\_group\_arn\_suffix) | ALB Target group ARN suffix |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | ALB Target group name |
<!-- markdownlint-restore -->
