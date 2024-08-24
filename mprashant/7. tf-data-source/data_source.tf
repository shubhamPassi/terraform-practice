data "aws_security_group" "name" {
  tags = {
    Name = "shubham-sg"
  }
}

data "aws_vpc" "name" {
  tags = {
    Name = "shubham_vpc"
  }
}

data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.name.id ]
  }

  tags = {
    Name = "shubham_public_subnet"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [ data.aws_security_group.name.id ]
  associate_public_ip_address = true

  tags = {
    Name = "webserver"
  }
}
