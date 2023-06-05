module "alb" {
  source  = "cloudposse/alb/aws"
  version = "1.7.0"

  name                                    = var.name
  namespace                               = var.project
  stage                                   = var.environment
  tags                                    = var.tags
  http_port                               = var.http_port
  http_enabled                            = var.http_enabled
  http_ingress_cidr_blocks                = var.http_ingress_cidr_blocks
  http_ingress_prefix_list_ids            = var.http_ingress_prefix_list_ids
  https_port                              = var.https_port
  https_enabled                           = var.https_enabled
  https_ingress_cidr_blocks               = var.https_ingress_cidr_blocks
  https_ingress_prefix_list_ids           = var.https_ingress_prefix_list_ids
  https_ssl_policy                        = var.https_ssl_policy
  http2_enabled                           = var.http2_enabled
  health_check_path                       = var.health_check_path
  health_check_timeout                    = var.health_check_timeout
  health_check_healthy_threshold          = var.health_check_healthy_threshold
  health_check_unhealthy_threshold        = var.health_check_unhealthy_threshold
  health_check_interval                   = var.health_check_interval
  health_check_matcher                    = var.health_check_matcher
  access_logs_prefix                      = var.access_logs_prefix
  access_logs_enabled                     = var.access_logs_enabled
  alb_access_logs_s3_bucket_force_destroy = var.access_logs_s3_bucket_force_destroy
  deregistration_delay                    = var.deregistration_delay
  deletion_protection_enabled             = var.deletion_protection_enabled
  internal                                = var.internal
  idle_timeout                            = var.idle_timeout
  cross_zone_load_balancing_enabled       = var.cross_zone_load_balancing_enabled
  ip_address_type                         = var.ip_address_type
  vpc_id                                  = var.vpc_id
  subnet_ids                              = var.subnet_ids
  security_group_ids                      = var.security_group_ids
  certificate_arn                         = var.acm_certificate_arn
  target_group_name                       = var.target_group_name
  target_group_port                       = var.target_group_port
  target_group_target_type                = var.target_group_target_type
  target_group_additional_tags            = var.target_group_additional_tags
  additional_certs                        = var.additional_certs
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  count = var.enable_redirect_http_to_https ? 1 : 0

  listener_arn = module.alb.http_listener_arn
  priority     = var.redirect_http_to_https_priority

  action {
    type = "redirect"

    redirect {
      port        = var.https_port
      protocol    = "HTTPS"
      status_code = var.redirect_http_to_https_status_code
    }
  }

  condition {
    host_header {
      values = ["*${var.domain}"]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "alb-logs" {
  count                   = var.access_logs_enabled ? 1 : 0
  bucket                  = module.alb.access_logs_bucket_id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_security_group_rule" "allow-http-ipv6" {
  count             = var.http_enabled ? 1 : 0
  security_group_id = module.alb.security_group_id
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "tcp"
  ipv6_cidr_blocks  = var.http_ingress_ipv6_cidr_blocks
}

resource "aws_security_group_rule" "allow-https-ipv6" {
  count             = var.https_enabled ? 1 : 0
  security_group_id = module.alb.security_group_id
  type              = "ingress"
  from_port         = var.https_port
  to_port           = var.https_port
  protocol          = "tcp"
  ipv6_cidr_blocks  = var.https_ingress_ipv6_cidr_blocks
}
