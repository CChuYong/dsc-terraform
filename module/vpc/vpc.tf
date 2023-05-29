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

output "public_subnet_ids" {
    value = aws_subnet.public.*.id
    description = "VPC의 Public 서브넷 ID 목록"
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
  description = "VPC의 Private 서브넷 ID 목록"
}
