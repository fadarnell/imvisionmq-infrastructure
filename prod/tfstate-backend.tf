terraform {
  required_version = ">= 1.3"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "imvision-prod-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "imvision-prod-terraform-state-lock"
    role_arn       = "arn:aws:iam::463516065186:role/AdministratorAccess"
    encrypt        = "true"
  }
}
