resource "aws_security_group" "shubham_sg" {
  name   = "shubham-sg"
  vpc_id = aws_vpc.shubham_vpc.id

  # Inbound rules
  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks =["0.0.0.0/0"]
    protocol = "tcp"
  }

  # Inbound rules
  ingress {
    from_port = 22
    to_port = 22
    cidr_blocks =["0.0.0.0/0"]
    protocol = "tcp"
  }

  # Outbound Rules
  egress {
    from_port = 0       # enable for all ports
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"     # enable for all the protocol
  }

  tags = {
    Name = "shubham-sg"
  }
}