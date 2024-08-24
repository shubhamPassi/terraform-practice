locals {
  project = "project-1"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

resource "aws_instance" "main" {
  ami = var.ec2_config[count.index % length(var.ec2_config)].ami
  instance_type = var.ec2_config[count.index % length(var.ec2_config)].instance_type
  count = 4

  subnet_id = element(aws_subnet.public-subnet[*].id, count.index % length(aws_subnet.public-subnet))

  tags = {
    Name = "${local.project}-instance-${count.index}"
  }
}

# output "name" {
#   value = aws_subnet.public-subnet[*].id
# }