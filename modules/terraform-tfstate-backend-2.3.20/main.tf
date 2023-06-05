locals {
  role_account_id      = var.role_account_id == "" ? data.aws_caller_identity.current.account_id : var.role_account_id
  role_arn             = "arn:aws:iam::${local.role_account_id}:role/${var.role_name}"
  terraform_version    = var.terraform_minimum_version
  terraform_state_file = "terraform.tfstate"
  templatefile = templatefile("${path.module}/templates/terraform.tf.tpl", {
    region               = data.aws_region.current.name
    encrypt              = true
    bucket               = module.this.s3_bucket_id
    dynamodb_table       = module.this.dynamodb_table_name
    role_arn             = local.role_arn
    terraform_version    = local.terraform_version
    terraform_state_file = local.terraform_state_file
  })
  terraform_backend_config_file = format(
    "%s/%s",
    var.terraform_backend_config_file_path,
    var.terraform_backend_config_file_name
  )
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "this" {
  source                        = "cloudposse/tfstate-backend/aws"
  version                       = "0.40.1"
  namespace                     = var.name
  stage                         = var.environment
  name                          = "terraform"
  attributes                    = ["state"]
  tags                          = var.tags
  block_public_acls             = true
  block_public_policy           = true
  restrict_public_buckets       = true
  ignore_public_acls            = true
  read_capacity                 = var.read_capacity
  write_capacity                = var.write_capacity
  billing_mode                  = var.billing_mode
  enable_server_side_encryption = true
  enable_public_access_block    = true
  enable_point_in_time_recovery = false
  profile                       = ""
  role_arn                      = local.role_arn
  terraform_version             = local.terraform_version
  terraform_state_file          = local.terraform_state_file
  s3_bucket_name                = var.s3_bucket_name
}

resource "local_file" "terraform_backend_config" {
  count           = var.terraform_backend_config_file_path != "" ? 1 : 0
  content         = local.templatefile
  filename        = local.terraform_backend_config_file
  file_permission = "0644"
}
