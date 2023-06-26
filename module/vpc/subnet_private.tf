resource "aws_subnet" "private" {
  count = local.private_subnet_size
  cidr_block = cidrsubnet(local.private_subnet_cidr_prefix, 4, count.index)

  vpc_id = aws_vpc.vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index % local.az_count)
  # if) az_count = 2 이고, az별 subnet 수가 2이면 1a, 1b, 1a, 1b

  tags = {
    Name = "${local.vpc_name}-subnet-private-${count.index + 1}"
    VpcName = local.vpc_name
    "kubernetes.io/role/internal-elb" = local.is_eks ? "1" : null
  }
}

resource "aws_route_table_association" "private" {
  count = local.private_subnet_size

  route_table_id = aws_route_table.private[count.index % local.az_count].id
  subnet_id = aws_subnet.private[count.index].id
}

resource "aws_network_acl_association" "private" {
  count = local.private_subnet_size

  network_acl_id = aws_network_acl.private.id
  subnet_id = aws_subnet.private[count.index].id
}
