# VPC
output "vpc_id" {
    value = aws_vpc.shubham-vpc.id
}

locals {
  # To format the subnet IDs which may be multiples in the format of subnet_name = {id= , az= }
  public_subnet_output = {
    for key, config in local.public_subnet : key => { 
      subnet_id = aws_subnet.shubham-subnet[key].id
      az        = aws_subnet.shubham-subnet[key].availability_zone
    }
  }

  private_subnet_output = {
    for key, config in local.private_subnet : key => { 
      subnet_id = aws_subnet.shubham-subnet[key].id
      az        = aws_subnet.shubham-subnet[key].availability_zone
    }
  }
}

# Public Subnet IDs
output "public_subnet_id" {
    value = local.public_subnet_output 
}

# Private Subnet IDs
output "private_subnet_id" {
    value = local.private_subnet_output
}