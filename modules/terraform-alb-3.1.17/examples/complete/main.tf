provider "aws" {
  region = "us-east-1"
}

module "alb" {
  source = "../../"

  name        = "alb"
  project     = "example"
  environment = "test"

  vpc_id     = ""
  subnet_ids = []
}
