terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2" # Seoul Region
}

module "dsc_prod_vpc" {
  source = "./module/vpc"

  name = "prod_vpc"
  cidr_prefix = "10.0"
  zone_size = 3

  public_subnet_per_az_size = 1
  private_subnet_per_az_size = 2
  nat_per_az = true
}
