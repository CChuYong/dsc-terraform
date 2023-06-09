resource "aws_subnet" "public" {
  count = local.public_subnet_size
  cidr_block = cidrsubnet(local.public_subnet_cidr_prefix, 4, count.index)

  vpc_id = aws_vpc.vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index % local.az_count)

  tags = {
    Name = "${local.vpc_name}-subnet-public-${count.index + 1}"
    VpcName = local.vpc_name
    "kubernetes.io/role/elb" = local.is_eks ? "1" : null
  }
}

resource "aws_route_table_association" "public" {
  count = local.public_subnet_size

  route_table_id = aws_route_table.public[count.index % local.az_count].id
  subnet_id = aws_subnet.public[count.index].id
}

resource "aws_network_acl_association" "public" {
  count = local.public_subnet_size

  network_acl_id = aws_network_acl.public.id
  subnet_id = aws_subnet.public[count.index].id
}
