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

# Create EC2 instance
resource "aws_instance" "shubham_ec2_instance" {
  ami = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.shubham_sg.id ]

  tags = {
    Name = "shubham-ec2"
  }
}