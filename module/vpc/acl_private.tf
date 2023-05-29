resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.vpc_name}-acl-private"
  }
}

resource "aws_network_acl_rule" "private_outbound_allow_all" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}


resource "aws_network_acl_rule" "private_inbound_allow_all" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
