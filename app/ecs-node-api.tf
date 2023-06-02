locals {
  api_name              = var.node_api_ecs_settings.name
  api_prefix            = "api"
  api_domain            = "${local.api_prefix}.${local.app_domain}"
  api_port              = 3000
  api_health_check_path = "/api/healthcheck"
  api_image_repository  = aws_ecr_repository.node_api.repository_url
  api_image_tag         = var.node_api_ecs_settings.image_tag
}

module "alb-ingress-node-api" {
  source                                     = "git::ssh://git@gitlab.com/miquido/terraform/terraform-alb-ingress.git?ref=tags/3.1.21"
  name                                       = var.node_api_ecs_settings.name
  project                                    = var.project
  environment                                = var.environment
  tags                                       = var.tags
  vpc_id                                     = module.vpc.vpc_id
  listener_arns                              = [module.alb.http_listener_arn, module.alb.https_listener_arn]
  hosts                                      = [local.api_domain]
  port                                       = local.api_port
  health_check_path                          = local.api_health_check_path
  health_check_healthy_threshold             = 2
  health_check_interval                      = 60
  health_check_unhealthy_threshold           = 2
  alb_target_group_alarms_enabled            = true
  alb_target_group_alarms_treat_missing_data = "notBreaching"
  alb_arn_suffix                             = module.alb.alb_arn_suffix
  priority                                   = 90
}

resource "aws_route53_record" "node_api" {
  zone_id = aws_route53_zone.app_domain.zone_id
  name    = local.api_domain
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}

module "ecs-alb-task-node-api" {
  source = "git::ssh://git@gitlab.com/miquido/terraform/terraform-ecs-alb-task.git?ref=tags/5.6.31"

  name                                      = local.api_name
  project                                   = var.project
  environment                               = var.environment
  tags                                      = var.tags
  container_image                           = local.api_image_repository
  container_tag                             = local.api_image_tag
  container_port                            = local.api_port
  container_cpu                             = 0
  health_check_grace_period_seconds         = 100
  task_cpu                                  = var.node_api_ecs_settings.task_cpu
  task_memory                               = var.node_api_ecs_settings.task_memory
  desired_count                             = var.node_api_ecs_settings.min_capacity
  autoscaling_min_capacity                  = var.node_api_ecs_settings.min_capacity
  autoscaling_max_capacity                  = var.node_api_ecs_settings.max_capacity
  ecs_alarms_cpu_utilization_high_threshold = var.node_api_ecs_settings.cpu_utilization_high_threshold
  autoscaling_scale_up_adjustment           = var.node_api_ecs_settings.scale_up_adjustment
  autoscaling_enabled                       = true
  ecs_alarms_enabled                        = true
  assign_public_ip                          = false
  readonly_root_filesystem                  = false
  volumes_from                              = []
  logs_region                               = var.aws_region
  vpc_id                                    = module.vpc.vpc_id
  alb_target_group_arn                      = module.alb-ingress-node-api.target_group_arn
  ecs_cluster_arn                           = aws_ecs_cluster.main.arn
  security_group_ids                        = [module.vpc.vpc_main_security_group_id]
  subnet_ids                                = module.vpc.private_subnet_ids
  ecs_cluster_name                          = aws_ecs_cluster.main.name
  platform_version                          = "1.4.0"
  exec_enabled                              = var.ecs_task_exec_enabled
  force_new_deployment                      = true

  capacity_provider_strategies = [
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = 3
      base              = null
    }
  ]

  secrets = [
    {
      name      = "DATABASE_PASSWORD"
      ssmName   = aws_ssm_parameter.rds_password.name
      valueFrom = aws_ssm_parameter.rds_password.arn
    },

  ]

  envs = [
    {
      name  = "DATABASE_NAME"
      value = local.rds_db_name
    },
    {
      name  = "DATABASE_HOST"
      value = local.rds_db_host
    },
    {
      name  = "DATABASE_PORT"
      value = local.rds_db_port
    },
    {
      name  = "DATABASE_USER"
      value = local.rds_db_user
    },
  ]
}
