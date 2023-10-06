terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "terraform.tfstate"
  }
}

provider "aws" {

  region = "us-east-1"
}
