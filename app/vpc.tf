module "vpc" {
  source                          = "git::ssh://git@gitlab.com/miquido/terraform/terraform-vpc.git?ref=tags/10.0.0"
  name                            = "main"
  project                         = var.project
  environment                     = var.environment
  tags                            = var.tags
  azs                             = var.aws_azs
  nat_type                        = "gateway-single"
  enable_ecs_fargate_private_link = false
  subnet_type_tag_key             = "${var.project}/subnet/type"
}