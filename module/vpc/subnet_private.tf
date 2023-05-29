resource "aws_subnet" "private" {
  count = local.private_subnet_size
  cidr_block = cidrsubnet(local.private_subnet_cidr_prefix, 2, count.index)

  vpc_id = aws_vpc.vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index % local.az_count)

  tags = {
    Name = "${local.vpc_name}-subnet-private-${count.index + 1}"
    VpcName = local.vpc_name
  }
}

resource "aws_route_table_association" "private" {
  count = local.private_subnet_size

  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private[count.index].id
}

resource "aws_network_acl_association" "private" {
  count = local.private_subnet_size

  network_acl_id = aws_network_acl.private.id
  subnet_id = aws_subnet.private[count.index].id
}
