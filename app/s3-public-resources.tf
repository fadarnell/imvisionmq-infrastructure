locals {
  public_resources_cf_id     = module.public_resources.cf_id
  public_resources_cf_arn    = module.public_resources.cf_arn
  public_resources_s3_bucket = module.public_resources.s3_bucket
  public_resources_domain    = "${var.public_resources_name}.${local.app_domain}"
}

module "public_resources" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.90.0"

  name      = var.public_resources_name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags

  aliases             = [local.public_resources_domain]
  acm_certificate_arn = module.acm_alb.arn
  dns_alias_enabled   = true
  parent_zone_name    = local.app_domain

  allowed_methods          = ["GET", "HEAD"]
  encryption_enabled       = true
  default_root_object      = "index.html"
  index_document           = "index.html"
  price_class              = "PriceClass_100"
  viewer_protocol_policy   = "redirect-to-https"
  origin_force_destroy     = true
  compress                 = true
  minimum_protocol_version = "TLSv1.2_2019"
  forward_query_string     = true
  forward_cookies          = "none"
  min_ttl                  = "2678400" //31 days
  default_ttl              = "2678400" //31 days
  forward_header_values    = []
  log_versioning_enabled   = true
  versioning_enabled       = true

  custom_error_response = [
    {
      error_code            = "404"
      response_code         = "200"
      error_caching_min_ttl = "2678400" //31 days
      response_page_path    = "/index.html"
    },
  ]
}