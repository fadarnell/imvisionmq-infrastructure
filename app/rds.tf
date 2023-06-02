locals {
  rds_db_name     = "db${var.environment}"
  rds_db_user     = "user${var.environment}"
  rds_db_port     = 5432
  rds_db_password = random_password.rds_main_password.result
  rds_db_host     = module.rds-instance[0].instance_address
}

resource "random_password" "rds_main_password" {
  length  = 32
  lower   = true
  numeric = true
  upper   = true
  special = false
}

module "rds-instance" {
  count                        = var.rds_type == "instance" ? 1 : 0
  source                       = "git::https://github.com/cloudposse/terraform-aws-rds?ref=tags/0.42.1"
  name                         = "database"
  namespace                    = var.project
  stage                        = var.environment
  tags                         = var.tags
  vpc_id                       = module.vpc.vpc_id
  subnet_ids                   = module.vpc.private_subnet_ids
  security_group_ids           = [module.vpc.vpc_main_security_group_id]
  database_name                = local.rds_db_name
  database_user                = local.rds_db_user
  database_password            = local.rds_db_password
  database_port                = local.rds_db_port
  storage_type                 = "gp2"
  allocated_storage            = 20
  max_allocated_storage        = 1024
  storage_encrypted            = true
  multi_az                     = var.db_multi_az
  engine                       = "postgres"
  engine_version               = "14.6"
  major_engine_version         = "14"
  instance_class               = var.aws_rds_instance_class
  db_parameter_group           = "postgres14"
  backup_retention_period      = "7"
  backup_window                = "00:15-03:15"
  maintenance_window           = "Tue:04:00-Tue:07:00"
  performance_insights_enabled = var.aws_rds_performance_insights_enabled
  allow_major_version_upgrade  = var.aws_rds_allow_major_version_upgrade
  apply_immediately            = var.aws_rds_apply_immediately
}

module "rds-instance-alarms" {
  count          = var.rds_type == "instance" ? 1 : 0
  source         = "git::ssh://git@gitlab.com/miquido/terraform/terraform-aws-rds-cloudwatch-sns-alarms.git?ref=tags/1.1.6"
  name           = module.rds-instance[count.index].instance_id
  stage          = var.environment
  namespace      = var.project
  tags           = var.tags
  db_instance_id = module.rds-instance[count.index].instance_id
}
