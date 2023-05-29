resource "aws_route_table" "public" {
  count = local.az_count #AZ개수만큼 만들어지고, AZ 순서대로임
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.vpc_name}-rt-public-${count.index + 1}"
  }
}

resource "aws_route" "igw_route" {
  count = local.az_count
  route_table_id = aws_route_table.public[count.index].id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}
