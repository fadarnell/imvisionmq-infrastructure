locals {
  ses_system_domain            = local.app_domain
  ses_region                   = var.aws_ses_region
  ses_zone_id                  = aws_route53_zone.app_domain.zone_id
  ses_project_name             = "${var.project}-${var.environment}"
  ses_system_dmarc_rua_address = "devops+imvision@miquido.com"
  ses_system_mail_from_domain  = "bounces.${local.ses_system_domain}"
  mail_recipient               = "devops+imvision@miquido.com"
  mail_forwarder_sender        = "noreply-forwarder@${local.ses_system_domain}"
  s3_bucket_ses_store          = aws_s3_bucket.ses-store.arn
}

resource "aws_ses_domain_identity" "ses-system" {
  domain   = local.ses_system_domain
  provider = aws.ses
}

resource "aws_ses_email_identity" "ses-email" {

  email    = "no-reply@${local.ses_system_domain}"
  provider = aws.ses
}

resource "aws_route53_record" "ses-system-verification-record" {
  zone_id = local.ses_zone_id
  name    = "_amazonses.${local.ses_system_domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses-system.verification_token]
}

resource "aws_ses_domain_identity_verification" "ses-system-verification" {
  domain     = aws_ses_domain_identity.ses-system.id
  depends_on = [aws_route53_record.ses-system-verification-record]
  provider   = aws.ses
}

resource "aws_ses_domain_dkim" "ses-system" {
  domain   = aws_ses_domain_identity.ses-system.domain
  provider = aws.ses
}

resource "aws_route53_record" "ses-system-dkim-tokens-records" {
  count   = 3
  zone_id = local.ses_zone_id
  name    = "${element(aws_ses_domain_dkim.ses-system.dkim_tokens, count.index)}._domainkey.${local.ses_system_domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.ses-system.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_ses_domain_mail_from" "ses-system" {
  domain           = aws_ses_domain_identity.ses-system.domain
  mail_from_domain = local.ses_system_mail_from_domain
  provider         = aws.ses
}

resource "aws_route53_record" "ses-system-mail-from-mx" {
  zone_id = local.ses_zone_id
  name    = local.ses_system_mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${local.ses_region}.amazonses.com"]
}

resource "aws_route53_record" "ses-system-mail-from-spf" {
  zone_id = local.ses_zone_id
  name    = local.ses_system_mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

resource "aws_route53_record" "ses-system-dmarc" {
  zone_id = local.ses_zone_id
  name    = "_dmarc.${local.ses_system_domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=DMARC1;p=reject;rua=mailto:${local.ses_system_dmarc_rua_address}"]
}

##################
# Email Receiving
##################

resource "aws_route53_record" "ses-system-mx-receive" {
  zone_id         = local.ses_zone_id
  name            = local.ses_system_domain
  type            = "MX"
  ttl             = "600"
  allow_overwrite = true
  records         = ["10 inbound-smtp.${local.ses_region}.amazonaws.com"]
}

locals {
  primary_rule_set_name = "primary-rules"
  ses_system_recipient  = local.ses_system_domain
  ses_s3_store_bucket   = "${local.ses_project_name}-ses-store"
}

resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = local.primary_rule_set_name
  provider      = aws.ses
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
  provider      = aws.ses
}

resource "aws_ses_receipt_rule" "bounce-no-reply-addresses" {
  name          = "bounce-no-reply-addresses"
  rule_set_name = local.primary_rule_set_name
  provider      = aws.ses

  recipients = [
    "bounces@${local.ses_system_domain}",
    "no-reply@${local.ses_system_domain}",
    "noreply@${local.ses_system_domain}",
    local.mail_forwarder_sender,
  ]

  enabled      = true
  scan_enabled = true

  add_header_action {
    header_name  = "Custom-Header"
    header_value = "Added by SES"
    position     = 1
  }

  bounce_action {
    message         = "This is an unattended mailbox, your message has been discarded."
    sender          = "bounces@${local.ses_system_domain}"
    smtp_reply_code = "550"
    status_code     = "5.5.1"
    position        = 2
  }

  s3_action {
    bucket_name       = aws_s3_bucket.ses-store.id
    object_key_prefix = "emails/bounces/${local.ses_system_domain}"
    position          = 3
  }

  stop_action {
    scope    = "RuleSet"
    position = 4
  }

  depends_on = [aws_s3_bucket_policy.ses-store, aws_ses_domain_identity_verification.ses-system-verification]
}

resource "aws_ses_receipt_rule" "ses-system-s3-store" {
  name          = "store-system-${local.ses_project_name}-feedback-in-s3"
  rule_set_name = local.primary_rule_set_name
  after         = aws_ses_receipt_rule.bounce-no-reply-addresses.name
  provider      = aws.ses

  recipients   = [local.ses_system_recipient]
  enabled      = true
  scan_enabled = true

  add_header_action {
    header_name  = "Custom-Header"
    header_value = "Added by SES"
    position     = 1
  }

  s3_action {
    bucket_name       = aws_s3_bucket.ses-store.id
    object_key_prefix = "emails/main/${local.ses_system_domain}"
    position          = 2
  }

  lambda_action {
    function_arn    = module.ses-email-forwarder-lambda-system-main.lambda_arn
    invocation_type = "Event"
    position        = 3
  }

  stop_action {
    scope    = "RuleSet"
    position = 4
  }

  depends_on = [aws_s3_bucket_policy.ses-store, aws_ses_domain_identity_verification.ses-system-verification]
}

resource "aws_s3_bucket" "ses-store" {
  bucket        = local.ses_s3_store_bucket
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "ses-store-versioning" {
  bucket = aws_s3_bucket.ses-store.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ses-store-ownership" {
  bucket = aws_s3_bucket.ses-store.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "ses-store-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.ses-store-ownership]

  bucket = aws_s3_bucket.ses-store.id
  acl    = "private"
}

module "ses-store" {
  source  = "cloudposse/s3-bucket/aws"
  version = "2.0.1"

  acl                          = "private"
  enabled                      = true
  versioning_enabled           = true
  name                         = "ses-store"
  stage                        = var.environment
  namespace                    = var.project
  allow_encrypted_uploads_only = false
  sse_algorithm                = "AES256"
}


data "aws_iam_policy_document" "ses-store" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:Referer"

      values = [
        var.aws_used_account_no,
      ]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${local.s3_bucket_ses_store}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "ses-store" {
  bucket                  = aws_s3_bucket.ses-store.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "ses-store" {
  bucket     = aws_s3_bucket.ses-store.id
  policy     = data.aws_iam_policy_document.ses-store.json
  depends_on = [aws_s3_bucket_public_access_block.ses-store]
}

##################
# EMAIL FORWARDING
##################

module "ses-email-forwarder-lambda-system-main" {
  source = "git::ssh://git@gitlab.com/miquido/terraform/terraform-ses-email-forwarder-lambda.git?ref=tags/1.2.4"

  providers = {
    aws = aws.ses
  }

  name                           = "system"
  namespace                      = var.project
  stage                          = var.environment
  tags                           = var.tags
  ses_region                     = local.ses_region
  mail_sender                    = local.mail_forwarder_sender
  mail_recipient                 = local.mail_recipient
  mail_s3_bucket                 = aws_s3_bucket.ses-store.id
  mail_s3_bucket_prefix          = "emails/main/${local.ses_system_domain}"
}
