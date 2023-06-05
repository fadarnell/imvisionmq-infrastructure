<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_burst_balance_too_low_label"></a> [burst\_balance\_too\_low\_label](#module\_burst\_balance\_too\_low\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_cpu_credit_balance_too_low_label"></a> [cpu\_credit\_balance\_too\_low\_label](#module\_cpu\_credit\_balance\_too\_low\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_cpu_utilization_too_high_label"></a> [cpu\_utilization\_too\_high\_label](#module\_cpu\_utilization\_too\_high\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_db_event_subscription_default_label"></a> [db\_event\_subscription\_default\_label](#module\_db\_event\_subscription\_default\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_disk_queue_depth_too_high_label"></a> [disk\_queue\_depth\_too\_high\_label](#module\_disk\_queue\_depth\_too\_high\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_free_storage_space_too_low_label"></a> [free\_storage\_space\_too\_low\_label](#module\_free\_storage\_space\_too\_low\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_freeable_memory_too_low_label"></a> [freeable\_memory\_too\_low\_label](#module\_freeable\_memory\_too\_low\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_sns_topic_default_label"></a> [sns\_topic\_default\_label](#module\_sns\_topic\_default\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |
| <a name="module_swap_usage_too_high_label"></a> [swap\_usage\_too\_high\_label](#module\_swap\_usage\_too\_high\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.burst_balance_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_credit_balance_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.disk_queue_depth_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free_storage_space_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.freeable_memory_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.swap_usage_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_event_subscription.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_event_subscription) | resource |
| [aws_sns_topic.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | List of attributes to add to label. | `list(string)` | `[]` | no |
| <a name="input_burst_balance_threshold"></a> [burst\_balance\_threshold](#input\_burst\_balance\_threshold) | The minimum percent of General Purpose SSD (gp2) burst-bucket I/O credits available. | `string` | `20` | no |
| <a name="input_cpu_credit_balance_threshold"></a> [cpu\_credit\_balance\_threshold](#input\_cpu\_credit\_balance\_threshold) | The minimum number of CPU credits (t2 instances only) available. | `string` | `20` | no |
| <a name="input_cpu_utilization_threshold"></a> [cpu\_utilization\_threshold](#input\_cpu\_utilization\_threshold) | The maximum percentage of CPU utilization. | `string` | `80` | no |
| <a name="input_db_instance_id"></a> [db\_instance\_id](#input\_db\_instance\_id) | The instance ID of the RDS database instance that you want to monitor. | `string` | n/a | yes |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | The delimiter to be used in labels. | `string` | `"-"` | no |
| <a name="input_disk_queue_depth_threshold"></a> [disk\_queue\_depth\_threshold](#input\_disk\_queue\_depth\_threshold) | The maximum number of outstanding IOs (read/write requests) waiting to access the disk. | `string` | `64` | no |
| <a name="input_free_storage_space_threshold"></a> [free\_storage\_space\_threshold](#input\_free\_storage\_space\_threshold) | The minimum amount of available storage space in Byte. | `string` | `2000000000` | no |
| <a name="input_freeable_memory_threshold"></a> [freeable\_memory\_threshold](#input\_freeable\_memory\_threshold) | The minimum amount of available random access memory in Byte. | `string` | `64000000` | no |
| <a name="input_name"></a> [name](#input\_name) | Name (unique identifier for app or service) | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (e.g. `cp` or `cloudposse`) | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (e.g. `prod`, `dev`, `staging`) | `string` | n/a | yes |
| <a name="input_swap_usage_threshold"></a> [swap\_usage\_threshold](#input\_swap\_usage\_threshold) | The maximum amount of swap space used on the DB instance in Byte. | `string` | `256000000` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key-value pairs to use for tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic |
<!-- markdownlint-restore -->
