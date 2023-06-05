provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                          = "../../"
  name                            = "main"
  project                         = "example"
  environment                     = "dev"
  azs                             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  nat_type                        = "gateway-single"
  enable_ecs_fargate_private_link = true
}
