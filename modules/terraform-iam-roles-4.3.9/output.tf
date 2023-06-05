output "role_names" {
  description = "All created roles by module"

  value = compact(
    [
      var.role_superadmin_enabled ? local.role_superadmin : "",
      var.role_admin_enabled ? local.role_admin : "",
      var.role_readonly_enabled ? local.role_readonly : "",
      var.role_alexa_enabled ? local.role_alexa : "",
      var.role_analyst_enabled ? local.role_analyst : "",
    ],
  )
}

output "role_readonly_access_arn" {
  description = "ARN of Read Only Access IAM Role"
  value       = join("", aws_iam_role.readonly-access.*.arn)
}

output "role_readonly_access_id" {
  description = "Name of Read Only Access IAM Role"
  value       = join("", aws_iam_role.readonly-access.*.id)
}

output "role_superadmin_access_arn" {
  description = "ARN of Administrator Access IAM Role (ability to manage CloudTrail)"
  value       = join("", aws_iam_role.super-administrator-access.*.arn)
}

output "role_superadmin_access_id" {
  description = "Name of Administrator Access IAM Role (ability to manage CloudTrail)"
  value       = join("", aws_iam_role.super-administrator-access.*.id)
}

output "role_admin_access_arn" {
  description = "ARN of Administrator Access IAM Role"
  value       = join("", aws_iam_role.administrator-access.*.arn)
}

output "role_admin_access_id" {
  description = "Name of Administrator Access IAM Role"
  value       = join("", aws_iam_role.administrator-access.*.id)
}

output "role_alexa_developer_arn" {
  description = "ARN of Administrator Access IAM Role"
  value       = join("", aws_iam_role.alexa-developer.*.arn)
}

output "role_alexa_developer_id" {
  description = "Name of Administrator Access IAM Role"
  value       = join("", aws_iam_role.alexa-developer.*.id)
}

output "role_analyst_developer_arn" {
  description = "ARN of Analyst Access IAM Role"
  value       = join("", aws_iam_role.analyst-access.*.arn)
}

output "role_analyst_developer_id" {
  description = "Name of Analyst Access IAM Role"
  value       = join("", aws_iam_role.analyst-access.*.id)
}

