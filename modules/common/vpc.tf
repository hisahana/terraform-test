variable name {}

resource "aws_vpc" "vpc" {
  cidr_block = "10.8.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = format("%s-%s", var.name, "vpc")
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-%s", var.name, "gateway")
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-%s", var.name, "public-route-table")
  }
}
