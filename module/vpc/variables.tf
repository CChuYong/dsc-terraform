variable "name" {
  type = string
  description = "VPC 이름"
}

variable "zone_size" {
  type = number
  description = "Availability Zone 크기"
  default = 3
  validation {
    condition = var.zone_size > 0 && var.zone_size < 5
    error_message = "Availability Zone 크기는 1~4 사이여야 합니다."
  }
}

variable "cidr_prefix" {
    type = string
    description = "VPC CIDR Prefix"
    default = "10.0"
}

variable "public_subnet_per_az_size" {
  type = number
  description = "AZ별 Public Subnet 개수"
  default = 1
  validation {
    condition = var.public_subnet_per_az_size > 0 && var.public_subnet_per_az_size < 5
    error_message = "Public Subnet 개수는 1~4 사이여야 합니다."
  }
}

variable "private_subnet_per_az_size" {
  type = number
  description = "AZ별 Private Subnet 개수"
  default = 1
  validation {
    condition = var.private_subnet_per_az_size > 0 && var.private_subnet_per_az_size < 5
    error_message = "Private Subnet 개수는 1~4 사이여야 합니다."
  }
}

variable "nat_per_az" {
  type = bool
  description = "AZ별 NAT Gateway 생성 여부"
  default = false
}

locals {
  vpc_name = var.name
  vpc_cidr = "${var.cidr_prefix}.0.0/16"

  az_count = var.zone_size
  nat_per_az = var.nat_per_az

  public_subnet_per_az_size = var.public_subnet_per_az_size
  private_subnet_per_az_size = var.private_subnet_per_az_size

  public_subnet_size = var.zone_size * var.public_subnet_per_az_size
  private_subnet_size = var.zone_size * var.private_subnet_per_az_size

  private_subnet_cidr_prefix = "${var.cidr_prefix}.0.0/20" #12개 -> 2^12 = 4096개
  public_subnet_cidr_prefix = "${var.cidr_prefix}.16.0/20" #12개 -> 4096개
}
