module "dynamic" {
  source             = "../.."
  ecs_cluster_arn    = "aws_ecs_cluster.main.arn"
  ecs_cluster_name   = "aws_ecs_cluster.main.name"
  project            = "var.project"
  environment        = "var.environment"
  security_group_ids = ["module.vpc.vpc_main_security_group_id"]
  subnet_ids         = ["module.vpc.private_subnet_ids"]
  vpc_id             = "module.vpc.vpc_id"
  alb_arn_suffix     = "module.alb.alb_arn_suffix"
  ingress_priority   = 79
  listener_arns      = ["module.alb.http_listener_arn", "module.alb.https_listener_arn"]
  host               = "*.dynamic.xd.cloud"
  zone_id            = "aws_route53_zone.default.zone_id"
  alb_dns_name       = "module.alb.alb_dns_name"
  alb_zone_id        = "module.alb.alb_zone_id"
  ci_cd_username     = "module.iam-user-cicd.user_name"
}