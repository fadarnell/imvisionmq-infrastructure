variable "environment" {
  default     = ""
  type        = string
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

variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR for the VPC"
}

variable "azs" {
  type        = list(string)
  default     = []
  description = "List of Availability Zones where subnets will be created"
}

variable "nat_type" {
  type        = string
  default     = "gateway-per-az"
  description = "Configure deployment of NAT instances/gateways for private subnets. Possible values are: gateway-per-az, gateway-single, instance-per-az and off."
}

variable "nat_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "NAT Instance type"
}

variable "subnet_type_tag_key" {
  type        = string
  default     = "miquido.com/subnet/type"
  description = "Key for subnet type tag to provide information about the type of subnets, e.g. `cpco.io/subnet/type=private` or `cpco.io/subnet/type=public`"
}

variable "subnet_type_tag_value_format" {
  type        = string
  default     = "%s"
  description = "This is using the format interpolation symbols to allow the value of the subnet_type_tag_key to be modified."
}

variable "max_subnet_count" {
  type        = number
  default     = 0
  description = "Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region"
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = true
  description = "Instances launched into a public subnet should be assigned a public IP address"
}

variable "enable_ecs_fargate_private_link" {
  type        = bool
  default     = false
  description = "Controls whether to create VPC Endpoints regarding AWS ECS with Fargate services in managed VPC"
}

variable "vpc_main_security_group_allow_self_ingress" {
  type        = bool
  default     = true
  description = "Add rule to main security group that allows all ingress traffic from the same group"
}

variable "vpc_main_security_group_allow_all_egress" {
  type        = bool
  default     = true
  description = "Add rule to main security group that allows all egress traffic"
}

variable "instance_tenancy" {
  type        = string
  default     = "default"
  description = "A tenancy option for instances launched into the VPC"
}

variable "private_subnets_additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to be added to private subnets"
}

variable "public_subnets_additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to be added to public subnets"
}

variable "ipv4_enabled" {
  type        = bool
  description = "Set `true` to enable IPv4 addresses in the subnets"
  default     = true
}

variable "ipv6_enabled" {
  type        = bool
  description = "Set `true` to enable IPv6 addresses in the subnets"
  default     = false
}
