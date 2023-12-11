data "aws_ssm_parameter" "rds_url" {
  name = "/${var.environment}/rds/url"
}

data "aws_ssm_parameter" "bigquery_key" {
  name = "/${var.environment}/bigquery/key"
}

module "bigquery-sync-lambda" {
  source = "../modules/terraform-cron-lambda-0.0.1"

  namespace       = var.project
  stage           = var.environment
  tags            = var.tags
  name            = "bigquery-sync"
  vpc_mode_enable = true
  timeout         = 360
  memory_size     = 512

  schedule_expression = "cron(0 4 * * ? *)"
  path_to_lambda_dir  = "${path.module}/../resources/lambda/bigquery-sync"

  env_variables = {
    BG_CASE_CARDS_ID           = "case_cards"
    BG_CASE_CARDS_TRANS_LOG_ID = "case_card_transition_logs"
    BG_CASE_CARD_LINK_ID       = "tenant_link_case_cards"
    BG_ORGS_ID                 = "tenant_organization"
    BG_PATIENTS_LINK_ID        = "tenant_link_patients"
    BG_ROLES_ID                = "roles"
    BG_ROLE_LINK_ID            = "tenant_link_roles"
    BG_TENANT_CONFIG_ID        = "tenant_config"
    BG_UNITS_ID                = "tenant_unit"
    BG_USERS_ID                = "users"
    BG_USER_LINK_ID            = "tenant_link_users"
    BG_USER_ROLES_ID           = "user_roles"
    BG_CONFIG_LINK_ID          = "tenant_link_config"

    BG_DATASET_ID = "imvision_${var.bigquery_dataset}_backend"

    PG_URI              = "${data.aws_ssm_parameter.rds_url.value}"
    SERVICE_ACCOUNT_KEY = "${data.aws_ssm_parameter.bigquery_key.value}"
  }

  vpc_config = {
    subnet_ids         = module.vpc.private_subnet_ids
    security_group_ids = [module.vpc.vpc_main_security_group_id, aws_security_group.bigquery_sync_public.id]
  }
}

resource "aws_security_group" "bigquery_sync_public" {
  name        = "bigquery-sync-public-security-group"
  description = "VPC bigquery_sync_public Security Group. Helps resolve SDK oAuth issues."
  vpc_id      = module.vpc.vpc_id
  tags = merge({
    Name = "bigquery-sync-public-security-group"
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow-public-ingress" {
  count = 1

  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bigquery_sync_public.id
}
