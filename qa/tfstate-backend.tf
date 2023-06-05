terraform {
  required_version = ">= 1.3"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "imvision-qa-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "imvision-qa-terraform-state-lock"
    role_arn       = "arn:aws:iam::219286167466:role/AdministratorAccess"
    encrypt        = "true"
  }
}
