module "aws-ecs-cluster-main-label" {
  source  = "cloudposse/label/terraform"
  version = "0.8.0"

  name      = "main"
  namespace = var.project
  stage     = var.environment
  tags      = var.tags
}

resource "aws_ecs_cluster" "main" {
  name = module.aws-ecs-cluster-main-label.id
  tags = module.aws-ecs-cluster-main-label.tags
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}