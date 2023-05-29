variable "cluster_name" {
    description = "클러스터 이름"
    type        = string
}

variable "subnet_ids" {
    description = "서브넷 아이디 목록"
    type        = list(string)
}

variable "eks_version" {
  description = "EKS 버전"
  type        = string
}

locals {
    cluster_name = var.cluster_name
    subnet_ids   = var.subnet_ids
  eks_version = var.eks_version
}
