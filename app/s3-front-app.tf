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

data "aws_iam_policy_document" "s3-frontend-upload-policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${local.frontend_app_s3_bucket}/*",
      "arn:aws:s3:::${local.frontend_app_s3_bucket}",
    ]
  }
}

data "aws_iam_policy_document" "frontend-cloudfront-invalidation-policy" {
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]

    resources = [
      local.frontend_app_cf_arn,
    ]
  }
}

resource "aws_iam_user_policy" "frontend-cloudfront-invalidation-policy" {
  user   = module.iam-user-cicd.user_name
  policy = data.aws_iam_policy_document.frontend-cloudfront-invalidation-policy.json
}

resource "aws_iam_user_policy" "frontend-s3-upload-policy" {
  user   = module.iam-user-cicd.user_name
  policy = data.aws_iam_policy_document.s3-frontend-upload-policy.json
}
