output "vpc" {
    value = module.vpc-module.vpc_ip
}

output "public_subnet_id" {
    value = module.vpc-module.public_subnet_id
}

output "private_subnet_id" {
    value = module.vpc-module.private_subnet_id
}