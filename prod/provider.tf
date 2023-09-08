provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_used_account_no}:role/${var.aws_used_role_name}"
  }
}
