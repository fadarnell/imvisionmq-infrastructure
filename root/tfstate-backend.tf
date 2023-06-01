terraform {
  required_version = ">= 0.13.5"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "imvision-root-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "imvision-root-terraform-state-lock"
    role_arn       = "arn:aws:iam::084203661098:role/AdministratorAccess"
    encrypt        = "true"
  }
}
