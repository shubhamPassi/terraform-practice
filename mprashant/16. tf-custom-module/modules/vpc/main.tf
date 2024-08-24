resource "aws_vpc" "shubham-vpc" {
  cidr_block = var.vpc_config.cidr_block_vpc
  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "shubham-subnet" {
  vpc_id = aws_vpc.shubham-vpc.id
  for_each = var.subnet_config  # key = {az, cidr} each.key each.value

  cidr_block = each.value.cidr_block_subnet
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

locals {
  public_subnet = {
    for key, config in var.subnet_config: key => config if config.public
  }

  private_subnet = {
    for key, config in var.subnet_config: key => config if config.public != true
  }
}

# Internet Gateway, if there is atleast one public subnet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.shubham-vpc.id
  count = length(local.public_subnet) > 0 ? 1 : 0
}

resource "aws_route_table" "route_table" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.shubham-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway[0].id
  }
}

resource "aws_route_table_association" "route_table_association" {
  for_each = local.public_subnet
  subnet_id = aws_subnet.shubham-subnet["${each.key}"].id
  route_table_id = aws_route_table.route_table[0].id
}