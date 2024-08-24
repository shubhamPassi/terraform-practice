# Create EC2 instance
resource "aws_instance" "shubham_ec2_instance" {
  ami = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.shubham_public_subnet.id
  user_data = <<-EOF
      #!/bin/bash
      sudo apt update
      sudo apt install nginx -y
      sudo systemctl start nginx
    EOF
  vpc_security_group_ids = [ aws_security_group.shubham_sg.id ]
  associate_public_ip_address = true
  tags = {
    Name = "shubham-ec2"
  }
}