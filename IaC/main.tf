terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Provider AWS
provider "aws" {
  region = "us-east-1"
}

# State file
terraform {
  backend "s3" {
    bucket  = "terraform-calcbmd"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

