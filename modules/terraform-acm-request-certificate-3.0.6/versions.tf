terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.7"
      configuration_aliases = [aws.acm, aws.dns]
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
}
