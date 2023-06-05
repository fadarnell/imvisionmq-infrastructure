module "vpc" {
  source                         = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=1.1.0"
  name                           = var.name
  namespace                      = var.project
  stage                          = var.environment
  cidr_block                     = var.cidr
  tags                           = var.tags
  instance_tenancy               = var.instance_tenancy
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = false
  enable_classiclink_dns_support = false
}

locals {
  nat = {
    "gateway-per-az" = {
      nat_gateway_enabled        = true
      nat_instance_enabled       = false
      nat_gateway_single_enabled = false
    }
    "gateway-single" = {
      nat_gateway_enabled        = true
      nat_instance_enabled       = false
      nat_gateway_single_enabled = true
    }
    "instance-per-az" = {
      nat_gateway_enabled        = false
      nat_instance_enabled       = true
      nat_gateway_single_enabled = false
    }
    "off" = {
      nat_gateway_enabled        = false
      nat_instance_enabled       = false
      nat_gateway_single_enabled = false
    }
  }

  nat_gateway_enabled        = local.nat[var.nat_type]["nat_gateway_enabled"]
  nat_instance_enabled       = local.nat[var.nat_type]["nat_instance_enabled"]
  nat_gateway_single_enabled = local.nat[var.nat_type]["nat_gateway_single_enabled"]
}

module "dynamic-subnets" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=2.1.0"
  name                         = var.name
  namespace                    = var.project
  stage                        = var.environment
  availability_zones           = var.azs
  vpc_id                       = module.vpc.vpc_id
  igw_id                       = [module.vpc.igw_id]
  ipv4_cidr_block              = [var.cidr]
  nat_gateway_enabled          = local.nat_gateway_enabled
  nat_instance_enabled         = local.nat_instance_enabled
  nat_instance_type            = var.nat_instance_type
  max_nats                     = local.nat_gateway_single_enabled ? 1 : 999
  max_subnet_count             = var.max_subnet_count
  subnet_type_tag_key          = var.subnet_type_tag_key
  subnet_type_tag_value_format = var.subnet_type_tag_value_format
  map_public_ip_on_launch      = var.map_public_ip_on_launch
  tags                         = var.tags

  public_subnets_additional_tags          = var.public_subnets_additional_tags
  private_subnets_additional_tags         = var.private_subnets_additional_tags
  ipv6_enabled                            = var.ipv6_enabled
  ipv4_enabled                            = var.ipv4_enabled
  public_assign_ipv6_address_on_creation  = var.ipv6_enabled
  private_assign_ipv6_address_on_creation = var.ipv6_enabled
}

module "label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label?ref=0.8.0"
  name      = var.name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags
}

resource "aws_security_group" "main" {
  name        = module.label.id
  description = "VPC Main Security Group - ${module.label.id}"
  vpc_id      = module.vpc.vpc_id
  tags = merge({
    Name = module.label.id
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "default-sg-allow-self-ingress" {
  count = var.vpc_main_security_group_allow_self_ingress ? 1 : 0

  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  self              = true
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "default-sg-allow-all-egress" {
  count = var.vpc_main_security_group_allow_all_egress ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.main.id
}
