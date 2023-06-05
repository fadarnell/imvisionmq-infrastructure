provider "aws" {
  region = "us-east-1"
}

module "alb-ingress" {
  source      = "../../"
  name        = "name"
  project     = "example"
  environment = "test"

  vpc_id = ""
}
