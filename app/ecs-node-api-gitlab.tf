data "gitlab_project" "node_api" {
  id = var.node_api_ecs_settings.gitlab_repo
}

resource "gitlab_project_variable" "node_api_aws_key" {
  project           = data.gitlab_project.node_api.id
  key               = "AWS_ACCESS_KEY_ID"
  value             = module.iam-user-cicd.access_key_id
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_aws_secret" {
  project           = data.gitlab_project.node_api.id
  key               = "AWS_SECRET_ACCESS_KEY"
  value             = module.iam-user-cicd.secret_access_key
  masked            = true
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_aws_region" {
  project           = data.gitlab_project.node_api.id
  key               = "AWS_DEFAULT_REGION"
  value             = var.aws_region
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_ecs_cluster_name" {
  project           = data.gitlab_project.node_api.id
  key               = "ECS_CLUSTER_NAME"
  value             = aws_ecs_cluster.main.name
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_ecs_service_name" {
  project           = data.gitlab_project.node_api.id
  key               = "ECS_SERVICE_NAME"
  value             = module.ecs-alb-task-node-api.service_name
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_registry" {
  project           = data.gitlab_project.node_api.id
  key               = "ECR_REPOSITORY"
  value             = aws_ecr_repository.node_api.repository_url
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_ecr" {
  project           = data.gitlab_project.node_api.id
  key               = "ECR_ID"
  value             = split("/", aws_ecr_repository.node_api.repository_url)[0]
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_env" {
  project           = data.gitlab_project.node_api.id
  key               = "env"
  value             = var.environment
  environment_scope = var.environment
}

resource "gitlab_project_variable" "node_api_container_name" {
  project           = data.gitlab_project.node_api.id
  key               = "CONTAINER_NAME"
  value             = "${var.project}-${var.environment}-${local.api_name}"
  environment_scope = var.environment
}
