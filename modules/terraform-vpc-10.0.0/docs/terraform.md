<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamic-subnets"></a> [dynamic-subnets](#module\_dynamic-subnets) | git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git | 0.39.8 |
| <a name="module_label"></a> [label](#module\_label) | git::https://github.com/cloudposse/terraform-terraform-label | 0.8.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/cloudposse/terraform-aws-vpc.git | 0.28.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.single-nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.single-nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.default-sg-allow-all-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default-sg-allow-self-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr-api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr-dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.ecr-api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.ecr-dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | List of Availability Zones where subnets will be created | `list(string)` | `[]` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_enable_ecs_fargate_private_link"></a> [enable\_ecs\_fargate\_private\_link](#input\_enable\_ecs\_fargate\_private\_link) | Controls whether to create VPC Endpoints regarding AWS ECS with Fargate services in managed VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `""` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Instances launched into a public subnet should be assigned a public IP address | `bool` | `true` | no |
| <a name="input_max_subnet_count"></a> [max\_subnet\_count](#input\_max\_subnet\_count) | Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource common name | `string` | n/a | yes |
| <a name="input_nat_instance_type"></a> [nat\_instance\_type](#input\_nat\_instance\_type) | NAT Instance type | `string` | `"t3.micro"` | no |
| <a name="input_nat_type"></a> [nat\_type](#input\_nat\_type) | Configure deployment of NAT instances/gateways for private subnets. Possible values are: gateway-per-az, gateway-single, instance-per-az and off. | `string` | `"gateway-per-az"` | no |
| <a name="input_private_network_acl_id"></a> [private\_network\_acl\_id](#input\_private\_network\_acl\_id) | Network ACL ID that will be added to private subnets. If empty, a new ACL will be created | `string` | `""` | no |
| <a name="input_private_subnets_additional_tags"></a> [private\_subnets\_additional\_tags](#input\_private\_subnets\_additional\_tags) | Additional tags to be added to private subnets | `map(string)` | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | Account/Project Name | `string` | n/a | yes |
| <a name="input_public_network_acl_id"></a> [public\_network\_acl\_id](#input\_public\_network\_acl\_id) | Network ACL ID that will be added to public subnets. If empty, a new ACL will be created | `string` | `""` | no |
| <a name="input_public_subnets_additional_tags"></a> [public\_subnets\_additional\_tags](#input\_public\_subnets\_additional\_tags) | Additional tags to be added to public subnets | `map(string)` | `{}` | no |
| <a name="input_subnet_type_tag_key"></a> [subnet\_type\_tag\_key](#input\_subnet\_type\_tag\_key) | Key for subnet type tag to provide information about the type of subnets, e.g. `cpco.io/subnet/type=private` or `cpco.io/subnet/type=public` | `string` | `"miquido.com/subnet/type"` | no |
| <a name="input_subnet_type_tag_value_format"></a> [subnet\_type\_tag\_value\_format](#input\_subnet\_type\_tag\_value\_format) | This is using the format interpolation symbols to allow the value of the subnet\_type\_tag\_key to be modified. | `string` | `"%s"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on repository | `map(string)` | `{}` | no |
| <a name="input_vpc_main_security_group_allow_all_egress"></a> [vpc\_main\_security\_group\_allow\_all\_egress](#input\_vpc\_main\_security\_group\_allow\_all\_egress) | Add rule to main security group that allows all egress traffic | `bool` | `true` | no |
| <a name="input_vpc_main_security_group_allow_self_ingress"></a> [vpc\_main\_security\_group\_allow\_self\_ingress](#input\_vpc\_main\_security\_group\_allow\_self\_ingress) | Add rule to main security group that allows all ingress traffic from the same group | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of Availability Zones where subnets were created |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | n/a |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | IDs of the NAT Gateways created |
| <a name="output_nat_instance_ids"></a> [nat\_instance\_ids](#output\_nat\_instance\_ids) | IDs of the NAT Instances created |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | IDs of the created private route tables |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | CIDR blocks of the created private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of the created private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | IDs of the created public route tables |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | CIDR blocks of the created public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of the created public subnets |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpc_ipv6_association_id"></a> [vpc\_ipv6\_association\_id](#output\_vpc\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block |
| <a name="output_vpc_ipv6_cidr"></a> [vpc\_ipv6\_cidr](#output\_vpc\_ipv6\_cidr) | The IPv6 CIDR block |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC |
| <a name="output_vpc_main_security_group_id"></a> [vpc\_main\_security\_group\_id](#output\_vpc\_main\_security\_group\_id) | The ID of the main security group associated with this VPC |
<!-- markdownlint-restore -->
