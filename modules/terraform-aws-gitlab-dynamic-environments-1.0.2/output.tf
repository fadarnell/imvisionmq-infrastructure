output "bucket_arn" {
  value = module.environments.bucket_arn
}

output "bucket_id" {
  value = module.environments.bucket_id
}

output "service_name" {
  value = module.ecs-alb-task-service-nginx.service_name
}