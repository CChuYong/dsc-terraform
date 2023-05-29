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

module "eks_cluster" {
  source = "./module/eks_cluster"
  cluster_name = "prod-eks-cluster"
  subnet_ids = concat(module.dsc_prod_vpc.private_subnet_ids, module.dsc_prod_vpc.public_subnet_ids)
  eks_version = "1.26"
}
