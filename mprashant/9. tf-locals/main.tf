locals {
  sufux_env = var.additional_tags.ENV
}

resource "aws_instance" "myserver" {
  ami = "ami-04a81a99f5ec58529"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_config.vol_size
    volume_type = var.ec2_config.vol_type
  }

  tags = merge(var.additional_tags, {
    Name = "webserver-${local.sufux_env}"
  })
}