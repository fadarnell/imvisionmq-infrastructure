terraform {
  required_version = ">= 1.3"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "imvision-dev-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "imvision-dev-terraform-state-lock"
    role_arn       = "arn:aws:iam::364823341760:role/AdministratorAccess"
    encrypt        = "true"
  }
}
