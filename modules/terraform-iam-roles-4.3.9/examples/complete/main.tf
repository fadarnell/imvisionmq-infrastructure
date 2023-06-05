provider "aws" {
  region = "us-east-1"
}

module "iam-roles" {
  source     = "../.."
  principals = ["xxxxx"]
}
