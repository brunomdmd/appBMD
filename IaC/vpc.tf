# VPC
resource "aws_vpc" "vpc01" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "PRD-VPC"
  }
}

# Subnets
resource "aws_subnet" "subnet01" {
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PRD-SUBNET01"
  }
}

resource "aws_subnet" "subnet02" {
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PRD-SUBNET02"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gtw01" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "PRD-GTW-01"
  }
}

# Route Table
resource "aws_route_table" "rt01" {
  vpc_id = aws_vpc.vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw01.id
  }
  tags = {
    Name = "PRD-RT-01"
  }
}

# Associar a rota criada com as subnets
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.rt01.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.rt01.id
}