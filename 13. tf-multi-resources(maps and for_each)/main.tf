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
  for_each = var.ec2_map      # We will get each.key and each.value

  ami = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.public-subnet[*].id, index(keys(var.ec2_map) ,each.key) % length(aws_subnet.public-subnet))

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

# output "name" {
#   value = aws_subnet.public-subnet[*].id
# }