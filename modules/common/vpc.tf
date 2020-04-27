variable name {}
variable avarability_zone_1 {}
variable avarability_zone_2 {}

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

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  availability_zone = var.avarability_zone_1
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  availability_zone = var.avarability_zone_2
}

resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2)
  availability_zone = var.avarability_zone_1
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 3)
  availability_zone = var.avarability_zone_2
}

resource "aws_route_table_association" "public1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public1.id
}

resource "aws_route_table_association" "public2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public2.id
}

resource "aws_security_group" "web" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
