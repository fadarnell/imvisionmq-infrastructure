module "alb" {
  source                              = "../modules/terraform-alb-3.1.17"
  name                                = ""
  domain                              = local.app_domain
  project                             = var.project
  environment                         = var.environment
  tags                                = var.tags
  vpc_id                              = module.vpc.vpc_id
  subnet_ids                          = module.vpc.public_subnet_ids
  security_group_ids                  = [module.vpc.vpc_main_security_group_id]
  enable_redirect_http_to_https       = true
  https_ssl_policy                    = "ELBSecurityPolicy-FS-1-2-2019-08"
  access_logs_s3_bucket_force_destroy = false
  access_logs_enabled                 = true
  acm_certificate_arn                 = module.acm_alb.arn
  idle_timeout                        = 600
}
