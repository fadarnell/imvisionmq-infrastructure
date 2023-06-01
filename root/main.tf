module "tfstate-backend" {
  source = "git::ssh://git@gitlab.com/miquido/terraform/terraform-tfstate-backend.git?ref=2.3.20"

  name                               = var.project
  environment                        = var.environment
  tags                               = var.tags
  terraform_backend_config_file_path = path.module
}

module "iam-roles" {
  source     = "git::ssh://git@gitlab.com/miquido/terraform/terraform-iam-roles.git?ref=4.3.9"
  principals = [var.authentication_account_no]
  tags       = var.tags
}
