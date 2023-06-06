 module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = "prod-eks-cluster"
  cluster_version                 = "1.27"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = module.dsc_prod_vpc.vpc_id
  subnet_ids = module.dsc_prod_vpc.private_subnet_ids

  cloudwatch_log_group_retention_in_days = 1

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "kube-system"
        },
        {
          namespace = "default"
        }
      ]
    }
  }
}
