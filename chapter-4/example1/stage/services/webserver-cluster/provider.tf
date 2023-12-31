terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}
