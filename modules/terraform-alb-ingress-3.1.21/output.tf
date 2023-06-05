output "target_group_name" {
  description = "ALB Target group name"
  value       = module.alb-ingress.target_group_name
}

output "target_group_arn" {
  description = "ALB Target group ARN"
  value       = module.alb-ingress.target_group_arn
}

output "target_group_arn_suffix" {
  description = "ALB Target group ARN suffix"
  value       = module.alb-ingress.target_group_arn_suffix
}

