module "tfstate-backend" {
  source = "../modules/terraform-tfstate-backend-2.3.20"

  name                               = var.project
  environment                        = var.environment
  tags                               = var.tags
  terraform_backend_config_file_path = path.module
}

module "iam-roles" {
  source     = "../modules/terraform-iam-roles-4.3.9"
  principals = [var.authentication_account_no]
  tags       = var.tags
}
