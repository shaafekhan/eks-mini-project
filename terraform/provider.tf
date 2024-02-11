terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.36.0"
    }
  }

  backend "s3" {
    bucket = "metabucket-tf"
    key    = "state/eks-mini-project.tfstate"
    region = "eu-west-1"
  }

}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

