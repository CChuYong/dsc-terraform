resource "aws_eip" "nat_eip" {
  count = local.nat_size
  vpc = true

  depends_on = [aws_internet_gateway.igw] # 사실 이 VPC 모듈 구조상 없을 수 없긴 함
  tags = {
    Name = "${local.vpc_name}-eip-nat-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = local.nat_size # AZ 개수 이거나 1
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id = aws_subnet.public[count.index].id
  # FIXME: 이거 Public Subnet이 AZ별로 순서대로 만들어진다는 내 코드상 가설떄문에 가능한 로직

  tags = {
    Name = "${local.vpc_name}-nat-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.igw]
}
