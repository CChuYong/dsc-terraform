resource "aws_route_table" "private" {
  count = local.az_count #AZ개수만큼 만들어지고, AZ 순서대로임
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.vpc_name}-rt-private-${count.index + 1}"
  }
}

resource "aws_route" "nat_route" {
  count = local.az_count
  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat[local.nat_per_az ? count.index : 0].id
}
