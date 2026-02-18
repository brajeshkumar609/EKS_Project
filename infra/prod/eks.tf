module "eks" {
  source = "../modules/eks"

  cluster_name       = "prod-eks"
  kubernetes_version = "1.29"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  # KMS off (minimal cost)
  kms_key_arn    = ""
  admin_role_arn = "" # optional; leave empty

  tags = { Environment = "prod", Platform = "eks" }
}
