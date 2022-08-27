terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
#    backend "s3" {
#    bucket = "kgkbucket"
#    key    = "terraform.tfstate"
#    region = "eu-central-1"
#  }
}

provider "aws" {
  region = "eu-central-1"
  #  access_key = ""
  #  secret_key = ""
}
