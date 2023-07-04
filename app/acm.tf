module "acm_alb" {
  source = "../modules/terraform-acm-request-certificate-3.0.6"

  providers = {
    aws.acm = aws
    aws.dns = aws
  }

  domain_name                 = local.app_domain
  ttl                         = "300"
  subject_alternative_names   = ["*.${local.app_domain}"]
  hosted_zone_id              = aws_route53_zone.app_domain.zone_id
  wait_for_certificate_issued = true
  tags                        = var.tags
}

module "acm_dynamic" {
  source = "../modules/terraform-acm-request-certificate-3.0.6"

  providers = {
    aws.acm = aws
    aws.dns = aws
  }

  domain_name                 = local.app_domain
  ttl                         = "300"
  subject_alternative_names   = ["*.dynamic.${local.app_domain}"]
  hosted_zone_id              = aws_route53_zone.app_domain.zone_id
  wait_for_certificate_issued = true
  tags                        = var.tags
}