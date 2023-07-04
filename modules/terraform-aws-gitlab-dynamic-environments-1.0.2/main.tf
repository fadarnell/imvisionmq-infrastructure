data "aws_region" "current" {}
data "aws_caller_identity" "current" {}


module "alb-ingress-service-nginx" {
  source                                     = "git::ssh://git@gitlab.com/miquido/terraform/terraform-alb-ingress.git?ref=tags/3.1.9"
  name                                       = "dyn-envs"
  project                                    = var.project
  environment                                = var.environment
  tags                                       = var.tags
  vpc_id                                     = var.vpc_id
  listener_arns                              = var.listener_arns
  hosts                                      = [var.host]
  port                                       = 80
  health_check_path                          = "/"
  health_check_healthy_threshold             = 2
  health_check_interval                      = 40
  health_check_unhealthy_threshold           = 5
  alb_target_group_alarms_enabled            = true
  alb_target_group_alarms_treat_missing_data = "notBreaching"
  alb_arn_suffix                             = var.alb_arn_suffix
  priority                                   = var.ingress_priority
}

module "ecs-alb-task-service-nginx" {
  source = "git::ssh://git@gitlab.com/miquido/terraform/terraform-ecs-alb-task.git?ref=tags/5.6.27"

  name                              = "dyn-envs"
  project                           = var.project
  environment                       = var.environment
  tags                              = var.tags
  container_image                   = "miquidocompany/dynamic-environments"
  container_tag                     = "latest"
  container_port                    = 80
  health_check_grace_period_seconds = 20
  task_cpu                          = var.task_cpu
  task_memory                       = var.task_memory
  desired_count                     = 1
  autoscaling_min_capacity          = 1
  autoscaling_max_capacity          = 1
  assign_public_ip                  = var.assign_public_ip
  readonly_root_filesystem          = false
  logs_region                       = data.aws_region.current.name
  vpc_id                            = var.vpc_id
  alb_target_group_arn              = module.alb-ingress-service-nginx.target_group_arn
  ecs_cluster_arn                   = var.ecs_cluster_arn
  security_group_ids                = var.security_group_ids
  subnet_ids                        = var.subnet_ids
  ecs_cluster_name                  = var.ecs_cluster_name
  platform_version                  = "1.4.0"
  exec_enabled                      = true
  ignore_changes_desired_count      = true

  envs = [
    {
      name  = "BUCKET"
      value = module.environments.bucket_id
    }
  ]

  efs_volumes = [
    {
      name      = "data"
      host_path = null
      efs_volume_configuration = [
        {
          file_system_id          = aws_efs_file_system.efs.id
          root_directory          = "/"
          transit_encryption      = "ENABLED"
          transit_encryption_port = 2999
          authorization_config = [{
            access_point_id = aws_efs_access_point.dynamic-envs.id
            iam             = "ENABLED"
          }]
      }]
    }
  ]

  mount_points = [
    {
      containerPath = "/var/efs"
      sourceVolume  = "data"
      readOnly      = false
    }
  ]


  healthcheck = {
    command     = ["CMD-SHELL", "curl -s http://localhost"]
    interval    = 60
    retries     = 5
    startPeriod = 100
    timeout     = 4
  }

  capacity_provider_strategies = [
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = 1
      base              = 1
    }
  ]
}

resource "aws_route53_record" "service-dynamic-env" {
  zone_id = var.zone_id
  name    = var.host
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "service-ipv6-dynamic-env" {
  zone_id = var.zone_id
  name    = var.host
  type    = "AAAA"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_efs_access_point" "dynamic-envs" {
  file_system_id = aws_efs_file_system.efs.id
  posix_user {
    gid = 0
    uid = 0
  }
  root_directory {
    path = "/dynamic-envs"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "0777"
    }
  }
}


resource "aws_efs_file_system" "efs" {
  encrypted = true
  tags = merge({
    Name = "Dynamic_envs"
  }, var.tags)
}

data "aws_iam_policy_document" "efs" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [aws_efs_file_system.efs.arn]
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:DescribeMountTargets"
    ]
  }
}

resource "aws_efs_file_system_policy" "efs-policy" {
  file_system_id = aws_efs_file_system.efs.id

  policy = data.aws_iam_policy_document.efs.json
}


resource "aws_efs_mount_target" "efs" {
  count           = length(var.subnet_ids)
  subnet_id       = var.subnet_ids[count.index]
  file_system_id  = aws_efs_file_system.efs.id
  security_groups = var.security_group_ids
}

module "environments" {
  source  = "cloudposse/s3-bucket/aws"
  version = "2.0.1"

  acl                          = "private"
  enabled                      = true
  versioning_enabled           = true
  name                         = "environments"
  stage                        = var.environment
  namespace                    = var.project
  allow_encrypted_uploads_only = false
  sse_algorithm                = "AES256"
}

data "aws_iam_policy_document" "s3-access" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${module.environments.bucket_arn}*"
    ]
  }

}

resource "aws_iam_role_policy" "s3-access-policy" {
  policy = data.aws_iam_policy_document.s3-access.json
  role   = module.ecs-alb-task-service-nginx.task_role_name
}

data "aws_iam_policy_document" "s3-dynamic" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]

    resources = [
      "${module.environments.bucket_arn}/*",
      "${module.environments.bucket_arn}*"
    ]
  }

  statement {
    actions = [
      "ecs:ListTasks"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:ExecuteCommand",
      "ecs:DescribeTasks"
    ]

    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task/${var.ecs_cluster_name}/*",
      var.ecs_cluster_arn
      #      "${var.ecs_cluster_arn}/*"
    ]
  }
}

resource "aws_iam_user_policy" "s3-dynamic-policy" {
  user   = var.ci_cd_username
  policy = data.aws_iam_policy_document.s3-dynamic.json
}
