module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

name = "my-first-vm"

  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  ami                    = "ami-04a81a99f5ec58529" 

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  
}