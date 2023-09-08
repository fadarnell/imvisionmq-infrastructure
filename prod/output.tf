##########################
# Terraform State Backend
##########################

output "tfstate_backend_config" {
  value = module.tfstate-backend.tf_backend_config
}

output "tfstate_backend_bucket_id" {
  value = module.tfstate-backend.s3_bucket_id
}

output "tfstate_backend_lock_table_name" {
  value = module.tfstate-backend.dynamodb_table_name
}

#########################
# IAM Roles
#########################

output "iam_roles" {
  value = module.iam-roles.role_names
}
