module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Private endpoint; you're running from an EC2 in the VPC
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  enable_irsa = true

  # --- Minimal cost: disable KMS (enable later if required)
  create_kms_key            = false
  cluster_encryption_config = null

  # Logs (low cost)
  cluster_enabled_log_types              = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = 30

  # One small node
  eks_managed_node_groups = {
    general = {
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      labels         = { pool = "general" }
    }
  }

  # v20+ AWS Auth
  enable_cluster_creator_admin_permissions = true

  access_entries = length(var.admin_role_arn) > 0 ? {
    admin = {
      principal_arn = var.admin_role_arn
      policy_associations = [{
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = { type = "cluster", namespaces = null }
      }]
      kubernetes_groups = ["system:masters"]
    }
  } : {}

  tags = var.tags
}

# Outputs only (no data sources here)
output "cluster_name"      { value = module.eks.cluster_name }
output "cluster_endpoint"  { value = module.eks.cluster_endpoint }
output "oidc_provider_arn" { value = module.eks.oidc_provider_arn }
output "vpc_id"            { value = var.vpc_id }
