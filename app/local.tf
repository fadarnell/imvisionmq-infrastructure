locals {

  app_domain = var.environment == "prod" ? "im.${var.top_domain}" : "${var.environment}.${var.top_domain}"

}