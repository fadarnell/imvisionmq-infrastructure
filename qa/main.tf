module "tfstate-backend" {
  source = "git::ssh://git@gitlab.com/miquido/terraform/terraform-tfstate-backend.git?ref=2.3.20"

  environment                        = var.environment
  name                               = var.project
  role_name                          = var.aws_used_role_name
  tags                               = var.tags
  terraform_backend_config_file_path = path.module
  terraform_minimum_version          = "1.3"
}

module "iam-roles" {
  source     = "git::ssh://git@gitlab.com/miquido/terraform/terraform-iam-roles.git?ref=4.3.9"
  principals = [var.authentication_account_no]
  tags       = var.tags
}
