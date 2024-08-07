resource "aws_security_group" "shubham_sg" {
  # Inbound rules
  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks =["0.0.0.0/0"]
    protocol = "tcp"
  }

  tags = {
    Name = "shubham-sg"
  }
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

# Create EC2 instance
resource "aws_instance" "shubham_ec2_instance" {
  subnet_id = aws_subnet.private.id
  ami = "ami-04a81a99f5ec58529"
  associate_public_ip_address = false
  instance_type = "t2.micro"
  # vpc_security_group_ids = [ aws_security_group.shubham_sg.id ]

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    replace_triggered_by = [ aws_security_group.shubham_sg ]
    
    precondition {
      condition = aws_security_group.shubham_sg.id != ""
      error_message = "Subnet Group ID must not be blank."
    }

    postcondition {
      condition = self.public_ip != ""
      error_message = "Public IP is not present."
    }
  } 
  
  tags = {
    Name = "shubham-ec2"
  }
}