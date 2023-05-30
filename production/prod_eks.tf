module "eks_cluster" {
  source = "../module/eks_cluster"
  cluster_name = "prod-eks-cluster"
  subnet_ids = concat(module.dsc_prod_vpc.private_subnet_ids, module.dsc_prod_vpc.public_subnet_ids)
  eks_version = "1.26"
}