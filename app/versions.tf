# Note: always specify only minimum required versions to not limit modules compatibility too strictly

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
      configuration_aliases = [aws.ses]
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = ">= 16.0.3"
    }
  }
}
