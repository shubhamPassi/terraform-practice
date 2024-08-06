output "vpc_id" {
    value = module.vpc-module.vpc_id
}

output "public_subnet_id" {
    value = module.vpc-module.public_subnet_id
}

output "private_subnet_id" {
    value = module.vpc-module.private_subnet_id
}