output "instance_public_ip" {
    description = "The public ip address of EC2 instance"
    value = aws_instance.shubham_ec2_instance.public_ip
}

output "instance_url" {
    description = "url to access nginx server"
    value = "http://${aws_instance.shubham_ec2_instance.public_ip}"
}