provider "aws" {
  region = "us-east-1"
}

module "acm_request_certificate" {
  providers = {
    aws.acm = aws
    aws.dns = aws
  }
  source                            = "../../"
  domain_name                       = "example.com"
  process_domain_validation_options = true
  ttl                               = "300"
  hosted_zone_id                    = "xxxxx"
}
