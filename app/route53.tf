resource "aws_route53_zone" "app_domain" {
  name = local.app_domain
}

#A record required for ACM Certificate validation
resource "aws_route53_record" "imvision_A_record" {
  count           = var.environment == "prod" ? 0 : 1
  zone_id         = aws_route53_zone.app_domain.zone_id
  name            = local.app_domain
  type            = "A"
  allow_overwrite = true
  ttl             = 3600
  records         = ["192.168.0.1"]
}
