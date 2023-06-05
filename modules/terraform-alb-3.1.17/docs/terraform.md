<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | git::https://github.com/kkmiquido/terraform-aws-alb | refactor-s3-resource-v4 |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener_rule.redirect_http_to_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_s3_bucket_public_access_block.alb-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group_rule.allow-http-ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow-https-ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_enabled"></a> [access\_logs\_enabled](#input\_access\_logs\_enabled) | A boolean flag to enable/disable access\_logs | `bool` | `true` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | The S3 log bucket prefix | `string` | `""` | no |
| <a name="input_access_logs_s3_bucket_force_destroy"></a> [access\_logs\_s3\_bucket\_force\_destroy](#input\_access\_logs\_s3\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The ARN of the default SSL certificate for HTTPS listener. Required if `https_enabled` is true. | `string` | `""` | no |
| <a name="input_additional_certs"></a> [additional\_certs](#input\_additional\_certs) | A list of additonal certs to add to the https listerner | `list(string)` | `[]` | no |
| <a name="input_cross_zone_load_balancing_enabled"></a> [cross\_zone\_load\_balancing\_enabled](#input\_cross\_zone\_load\_balancing\_enabled) | A boolean flag to enable/disable cross zone load balancing | `bool` | `false` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | A boolean flag to enable/disable deletion protection for ALB | `bool` | `false` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time to wait in seconds before changing the state of a deregistering target to unused | `number` | `15` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain to request ACM certificate for root domain and wildcard SAN | `string` | `""` | no |
| <a name="input_enable_redirect_http_to_https"></a> [enable\_redirect\_http\_to\_https](#input\_enable\_redirect\_http\_to\_https) | Attach rule to HTTP listener that redirects | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `""` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The duration in seconds in between health checks | `number` | `15` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | The HTTP response codes to indicate a healthy check | `string` | `"200-399"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination for the health check request | `string` | `"/"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The amount of time to wait in seconds before failing a health check request | `number` | `10` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | The number of consecutive health check failures required before considering the target unhealthy | `number` | `2` | no |
| <a name="input_http2_enabled"></a> [http2\_enabled](#input\_http2\_enabled) | A boolean flag to enable/disable HTTP/2 | `bool` | `true` | no |
| <a name="input_http_enabled"></a> [http\_enabled](#input\_http\_enabled) | A boolean flag to enable/disable HTTP listener | `bool` | `true` | no |
| <a name="input_http_ingress_cidr_blocks"></a> [http\_ingress\_cidr\_blocks](#input\_http\_ingress\_cidr\_blocks) | List of CIDR blocks to allow in HTTP security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_http_ingress_ipv6_cidr_blocks"></a> [http\_ingress\_ipv6\_cidr\_blocks](#input\_http\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks to allow in HTTP security group | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_http_ingress_prefix_list_ids"></a> [http\_ingress\_prefix\_list\_ids](#input\_http\_ingress\_prefix\_list\_ids) | List of prefix list IDs for allowing access to HTTP ingress security group | `list(string)` | `[]` | no |
| <a name="input_http_port"></a> [http\_port](#input\_http\_port) | The port for the HTTP listener | `number` | `80` | no |
| <a name="input_https_enabled"></a> [https\_enabled](#input\_https\_enabled) | A boolean flag to enable/disable HTTPS listener | `bool` | `true` | no |
| <a name="input_https_ingress_cidr_blocks"></a> [https\_ingress\_cidr\_blocks](#input\_https\_ingress\_cidr\_blocks) | List of CIDR blocks to allow in HTTPS security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_https_ingress_ipv6_cidr_blocks"></a> [https\_ingress\_ipv6\_cidr\_blocks](#input\_https\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks to allow in HTTPS security group | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_https_ingress_prefix_list_ids"></a> [https\_ingress\_prefix\_list\_ids](#input\_https\_ingress\_prefix\_list\_ids) | List of prefix list IDs for allowing access to HTTPS ingress security group | `list(string)` | `[]` | no |
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | The port for the HTTPS listener | `number` | `443` | no |
| <a name="input_https_ssl_policy"></a> [https\_ssl\_policy](#input\_https\_ssl\_policy) | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The time in seconds that the connection is allowed to be idle | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | A boolean flag to determine whether the ALB should be internal | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | `string` | `"ipv4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource common name | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Account/Project Name | `string` | n/a | yes |
| <a name="input_redirect_http_to_https_priority"></a> [redirect\_http\_to\_https\_priority](#input\_redirect\_http\_to\_https\_priority) | HTTP Listener Rule priority | `number` | `5` | no |
| <a name="input_redirect_http_to_https_status_code"></a> [redirect\_http\_to\_https\_status\_code](#input\_redirect\_http\_to\_https\_status\_code) | The HTTP redirect code. The redirect is either permanent (HTTP\_301) or temporary (HTTP\_302) | `string` | `"HTTP_301"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of additional security group IDs to allow access to ALB | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of (typically public) subnet IDs to associate with ALB. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on repository | `map(string)` | `{}` | no |
| <a name="input_target_group_additional_tags"></a> [target\_group\_additional\_tags](#input\_target\_group\_additional\_tags) | The additional tags to apply to the target group | `map(string)` | `{}` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name for the default target group, uses a module label name if left empty | `string` | `""` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | The port for the default target group | `number` | `80` | no |
| <a name="input_target_group_target_type"></a> [target\_group\_target\_type](#input\_target\_group\_target\_type) | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group | `string` | `"ip"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources are created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_logs_bucket_id"></a> [access\_logs\_bucket\_id](#output\_access\_logs\_bucket\_id) | The S3 bucket ID for access logs |
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the ALB |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | The ARN suffix of the ALB |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of ALB |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | The ARN suffix of the ALB |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | The ID of the zone which ALB is provisioned |
| <a name="output_default_target_group_arn"></a> [default\_target\_group\_arn](#output\_default\_target\_group\_arn) | The default target group ARN |
| <a name="output_http_listener_arn"></a> [http\_listener\_arn](#output\_http\_listener\_arn) | The ARN of the HTTP listener |
| <a name="output_https_listener_arn"></a> [https\_listener\_arn](#output\_https\_listener\_arn) | The ARN of the HTTPS listener |
| <a name="output_listener_arns"></a> [listener\_arns](#output\_listener\_arns) | A list of all the listener ARNs |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the ALB |
<!-- markdownlint-restore -->
