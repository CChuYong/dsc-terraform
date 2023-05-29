resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.vpc_name}-rt-private"
  }
}
