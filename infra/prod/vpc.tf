module "vpc" {
  source = "../modules/vpc"

  name            = "prod-ap-south-1"
  cidr            = "10.20.0.0/16"
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnets  = ["10.20.0.0/20", "10.20.16.0/20", "10.20.32.0/20"]
  private_subnets = ["10.20.128.0/20", "10.20.144.0/20", "10.20.160.0/20"]

  tags = { Environment = "prod", Platform = "eks" }
}

output "vpc_id"             { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnets }
output "public_subnet_ids"  { value = module.vpc.public_subnets }
