module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  enable_irsa = true

  cluster_encryption_config = {
    resources       = ["secrets"]
    provider_key_arn = var.kms_key_arn
  }

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = 30

  eks_managed_node_groups = {
    general = {
      min_size       = 2
      max_size       = 5
      desired_size   = 2
      instance_types = ["m6i.large"]
      capacity_type  = "ON_DEMAND"
      labels         = { pool = "general" }
    }
  }

  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = var.admin_role_arn
      username = "admin:{{SessionName}}"
      groups   = ["system:masters"]
    }
  ]

  tags = var.tags
}

output "cluster_name"          { value = module.eks.cluster_name }
output "cluster_endpoint"      { value = module.eks.cluster_endpoint }
output "oidc_provider_arn"     { value = module.eks.oidc_provider_arn }
output "vpc_id"                { value = var.vpc_id }
