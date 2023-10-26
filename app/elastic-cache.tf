locals {
  engine_version = "7.0"
  instance_type  = "cache.t4g.micro"
}

module "redis-cache" {
  source  = "cloudposse/elasticache-redis/aws"
  version = "0.52.0"

  name                         = "${var.project}-${var.environment}-cache"
  vpc_id                       = module.vpc.vpc_id
  allowed_security_group_ids   = [module.vpc.vpc_main_security_group_id]
  subnets                      = module.vpc.private_subnet_ids
  cluster_mode_enabled         = true
  instance_type                = local.instance_type
  apply_immediately            = true
  automatic_failover_enabled   = false
  engine_version               = local.engine_version
  multi_az_enabled             = false
  at_rest_encryption_enabled   = true
  transit_encryption_enabled   = false
  family                       = "redis7"
  cluster_mode_num_node_groups = 1
}
