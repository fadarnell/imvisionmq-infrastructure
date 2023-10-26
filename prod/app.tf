module "app" {
  providers = {
    aws     = aws
    aws.ses = aws
  }

  source              = "../app"
  top_domain          = var.top_domain
  project             = var.project
  environment         = var.environment
  aws_used_account_no = var.aws_used_account_no

  force_new_deployment = var.force_new_deployment

  aws_rds_instance_class               = "db.t4g.small"
  aws_rds_performance_insights_enabled = true
  aws_rds_allow_major_version_upgrade  = true
  aws_rds_apply_immediately            = true
  db_multi_az                          = false

  bastion_enabled       = true
  ecs_task_exec_enabled = true

  frontend_app_name    = ""
  frontend_gitlab_repo = "46489958"

  node_api_ecs_settings = {
    name                           = "node-api"
    gitlab_repo                    = "46489914" //https://gitlab.com/imvisionmq/imvisionmq-backend
    image_tag                      = "tbd"
    task_cpu                       = 512
    task_memory                    = 1024
    min_capacity                   = 1
    max_capacity                   = 3
    cpu_utilization_high_threshold = 80
    scale_up_adjustment            = 1
    desired_count                  = 1
  }

  tags           = var.tags
  aws_region     = var.aws_region
  aws_azs        = var.aws_azs
  aws_ses_region = var.aws_ses_region
}
