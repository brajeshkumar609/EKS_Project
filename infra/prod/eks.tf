module "eks" {
  source = "../modules/eks"

  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnets

  # TODO: replace with your KMS key for secrets encryption
  kms_key_arn   = "arn:aws:kms:ap-south-1:123456789012:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  # TODO: replace with your platform admin role
  admin_role_arn = "arn:aws:iam::123456789012:role/platform-eks-admin"

  tags = { Environment = "prod", Platform = "eks" }
}
