data "gitlab_project" "frontend_app" {
  id = var.frontend_gitlab_repo
}

resource "gitlab_project_variable" "frontend_aws_key" {
  project           = data.gitlab_project.frontend_app.id
  key               = "AWS_ACCESS_KEY_ID"
  value             = module.iam-user-cicd.access_key_id
  environment_scope = var.environment
}

resource "gitlab_project_variable" "frontend_aws_secret" {
  project           = data.gitlab_project.frontend_app.id
  key               = "AWS_SECRET_ACCESS_KEY"
  value             = module.iam-user-cicd.secret_access_key
  environment_scope = var.environment
  masked            = true
}

resource "gitlab_project_variable" "frontend_aws_region" {
  project           = data.gitlab_project.frontend_app.id
  key               = "AWS_DEFAULT_REGION"
  environment_scope = var.environment
  value             = var.aws_region
}

resource "gitlab_project_variable" "frontend_s3_bucket" {
  project           = data.gitlab_project.frontend_app.id
  key               = "S3_BUCKET"
  value             = module.frontend_app.s3_bucket
  environment_scope = var.environment
}

resource "gitlab_project_variable" "frontend_cf_distribution" {
  project           = data.gitlab_project.frontend_app.id
  key               = "CF_DIST_ID"
  value             = module.frontend_app.cf_id
  environment_scope = var.environment
}
