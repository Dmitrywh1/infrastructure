output "vpc" {
  value = module.vpc.vpc
}

output "subnet" {
  value = module.vpc.vpc_subnet
}