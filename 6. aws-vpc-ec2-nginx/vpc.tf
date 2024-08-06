# Create VPC
resource "aws_vpc" "shubham_vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "shubham_vpc"
  }
}

# Create Public subnet
resource "aws_subnet" "shubham_public_subnet" {
  vpc_id = aws_vpc.shubham_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "shubham_public_subnet"
  }
}

# Create private subnet
resource "aws_subnet" "shubham_private_subnet" {
  vpc_id = aws_vpc.shubham_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "shubham_private_subnet"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "shubham-gw" {
  vpc_id = aws_vpc.shubham_vpc.id
  tags = {
    Name = "shubham-gw"
  }
}

# Create route table
resource "aws_route_table" "shubham_public_rt" {
  vpc_id = aws_vpc.shubham_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shubham-gw.id
  }
    tags = {
      Name = "shubham_public_rt"
    }
}

# Connect public route table with public subnet 
resource "aws_route_table_association" "shubham_rt_association_public_sub" {
  subnet_id = aws_subnet.shubham_public_subnet.id
  route_table_id = aws_route_table.shubham_public_rt.id
}
