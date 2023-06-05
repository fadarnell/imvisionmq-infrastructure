output "igw_id" {
  value = module.vpc.igw_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_ipv6_association_id" {
  value       = module.vpc.vpc_ipv6_association_id
  description = "The association ID for the IPv6 CIDR block"
}

output "vpc_ipv6_cidr" {
  value       = module.vpc.vpc_ipv6_cidr_block
  description = "The IPv6 CIDR block"
}

output "vpc_main_route_table_id" {
  value       = module.vpc.vpc_main_route_table_id
  description = "The ID of the main route table associated with this VPC"
}

output "vpc_main_security_group_id" {
  value       = aws_security_group.main.id
  description = "The ID of the main security group associated with this VPC"
}

output "vpc_default_route_table_id" {
  value       = module.vpc.vpc_default_route_table_id
  description = "The ID of the route table created by default on VPC creation"
}

output "vpc_default_network_acl_id" {
  value       = module.vpc.vpc_default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation"
}

output "vpc_default_security_group_id" {
  value       = module.vpc.vpc_default_security_group_id
  description = "The ID of the security group created by default on VPC creation"
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways created"
  value       = module.dynamic-subnets.nat_gateway_ids
}

output "nat_instance_ids" {
  description = "IDs of the NAT Instances created"
  value       = module.dynamic-subnets.nat_instance_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.dynamic-subnets.private_route_table_ids
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = module.dynamic-subnets.private_subnet_ids
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.dynamic-subnets.public_route_table_ids
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = module.dynamic-subnets.public_subnet_ids
}


output "public_subnet_cidrs" {
  description = "CIDR blocks of the created public subnets"
  value       = module.dynamic-subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the created private subnets"
  value       = module.dynamic-subnets.private_subnet_cidrs
}

output "availability_zones" {
  description = "List of Availability Zones where subnets were created"
  value       = module.dynamic-subnets.availability_zones
}
