resource "aws_instance" "vpn_bastion" {
  ami           = "ami-08216dbbe630e9894"
  instance_type = "t4g.small"
  subnet_id = module.dsc_prod_vpc.public_subnet_ids[0]
  associate_public_ip_address = true
  security_groups = [aws_security_group.allow_ssh.id]

  lifecycle {
    ignore_changes = [security_groups]
  }

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.dsc_prod_vpc.vpc_id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
