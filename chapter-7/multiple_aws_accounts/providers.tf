terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "region_1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "region_2"
}
