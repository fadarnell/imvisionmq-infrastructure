locals {
  frontend_app_cf_id     = module.frontend_app.cf_id
  frontend_app_cf_arn    = module.frontend_app.cf_arn
  frontend_app_s3_bucket = module.frontend_app.s3_bucket
  frontend_app_domain    = "${var.frontend_app_name}.${local.app_domain}"
}

module "frontend_app" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.90.0"

  name      = var.frontend_app_name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags

  aliases             = [local.frontend_app_domain]
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

# resource "aws_s3_bucket_public_access_block" "front" {
#   bucket                  = local.frontend_app_s3_bucket
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }
