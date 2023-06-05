output "s3_bucket_domain_name" {
  value       = module.this.s3_bucket_domain_name
  description = "S3 bucket domain name"
}

output "s3_bucket_id" {
  value       = module.this.s3_bucket_id
  description = "S3 bucket ID"
}

output "s3_bucket_arn" {
  value       = module.this.s3_bucket_arn
  description = "S3 bucket ARN"
}

output "dynamodb_table_name" {
  description = "The name of created DynamoDB Table"
  value       = module.this.dynamodb_table_name
}

output "dynamodb_table_id" {
  description = "The ID of created DynamoDB Table"
  value       = module.this.dynamodb_table_id
}

output "dynamodb_table_arn" {
  description = "The ARN of created DynamoDB Table"
  value       = module.this.dynamodb_table_arn
}

output "tf_backend_config" {
  description = "Rendered Terraform backend config file"
  value       = local.templatefile
}
