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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cloudformation-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.deny-ct-write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam-role-power-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.serverlessrepo-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.administrator-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.alexa-developer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.analyst-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.readonly-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.super-administrator-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.administrator-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-alexa-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-cloudformation-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-iam-role-power-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-lambda-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-lex-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.alexa-developer-serverlessrepo-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.analyst-athena-full-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.analyst-readonly-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.deny-ct-write-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.super-administrator-access-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.administrator-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.alexa-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.athena-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.lambda-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.lex-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.readonly-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudformation-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deny-ct-write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam-role-power-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.serverlessrepo-full-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_external_id"></a> [assume\_role\_external\_id](#input\_assume\_role\_external\_id) | Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount | `string` | `""` | no |
| <a name="input_assume_role_mfa_enabled"></a> [assume\_role\_mfa\_enabled](#input\_assume\_role\_mfa\_enabled) | Whether to require MFA to assume enabled roles. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-mfa | `bool` | `true` | no |
| <a name="input_policies_prefix"></a> [policies\_prefix](#input\_policies\_prefix) | Prefix added to created roles | `string` | `""` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) | `list(string)` | n/a | yes |
| <a name="input_role_admin_enabled"></a> [role\_admin\_enabled](#input\_role\_admin\_enabled) | Whether to enable AdministratorAccess IAM Role | `bool` | `true` | no |
| <a name="input_role_alexa_enabled"></a> [role\_alexa\_enabled](#input\_role\_alexa\_enabled) | Whether to enable AlexaDeveloper IAM Role | `bool` | `false` | no |
| <a name="input_role_analyst_enabled"></a> [role\_analyst\_enabled](#input\_role\_analyst\_enabled) | Whether to enable Analyst IAM Role (ReadOnly + AmazonAthenaFullAccess) | `bool` | `false` | no |
| <a name="input_role_readonly_enabled"></a> [role\_readonly\_enabled](#input\_role\_readonly\_enabled) | Whether to enable ReadOnlyAccess IAM Role | `bool` | `true` | no |
| <a name="input_role_superadmin_enabled"></a> [role\_superadmin\_enabled](#input\_role\_superadmin\_enabled) | Whether to enable SuperAdministratorAccess IAM Role (Administrator with ability to manage CloudTrail) | `bool` | `false` | no |
| <a name="input_roles_max_session_duration"></a> [roles\_max\_session\_duration](#input\_roles\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `3600` | no |
| <a name="input_roles_prefix"></a> [roles\_prefix](#input\_roles\_prefix) | Prefix added to created roles | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply on all created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_admin_access_arn"></a> [role\_admin\_access\_arn](#output\_role\_admin\_access\_arn) | ARN of Administrator Access IAM Role |
| <a name="output_role_admin_access_id"></a> [role\_admin\_access\_id](#output\_role\_admin\_access\_id) | Name of Administrator Access IAM Role |
| <a name="output_role_alexa_developer_arn"></a> [role\_alexa\_developer\_arn](#output\_role\_alexa\_developer\_arn) | ARN of Administrator Access IAM Role |
| <a name="output_role_alexa_developer_id"></a> [role\_alexa\_developer\_id](#output\_role\_alexa\_developer\_id) | Name of Administrator Access IAM Role |
| <a name="output_role_analyst_developer_arn"></a> [role\_analyst\_developer\_arn](#output\_role\_analyst\_developer\_arn) | ARN of Analyst Access IAM Role |
| <a name="output_role_analyst_developer_id"></a> [role\_analyst\_developer\_id](#output\_role\_analyst\_developer\_id) | Name of Analyst Access IAM Role |
| <a name="output_role_names"></a> [role\_names](#output\_role\_names) | All created roles by module |
| <a name="output_role_readonly_access_arn"></a> [role\_readonly\_access\_arn](#output\_role\_readonly\_access\_arn) | ARN of Read Only Access IAM Role |
| <a name="output_role_readonly_access_id"></a> [role\_readonly\_access\_id](#output\_role\_readonly\_access\_id) | Name of Read Only Access IAM Role |
| <a name="output_role_superadmin_access_arn"></a> [role\_superadmin\_access\_arn](#output\_role\_superadmin\_access\_arn) | ARN of Administrator Access IAM Role (ability to manage CloudTrail) |
| <a name="output_role_superadmin_access_id"></a> [role\_superadmin\_access\_id](#output\_role\_superadmin\_access\_id) | Name of Administrator Access IAM Role (ability to manage CloudTrail) |
<!-- markdownlint-restore -->
