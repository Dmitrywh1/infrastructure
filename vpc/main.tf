#.
module "vpc" {
  source       = "./vpc"
  env_name     = "production"
  vpc_name     = "morgotq_vpc"
  subnets      = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" }
  ]
}
