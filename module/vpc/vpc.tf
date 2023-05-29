resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = local.vpc_name
  }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "VPC의 ID"
}
