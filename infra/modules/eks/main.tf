module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Keep private-only endpoint to stay secure/cost-neutral.
  # If you run terraform/kubectl from outside the VPC, set public access to true temporarily.
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  enable_irsa = true

  # If var.kms_key_arn is empty, skip envelope encryption config
  cluster_encryption_config = length(var.kms_key_arn) > 0 ? {
    resources        = ["secrets"]
    provider_key_arn = var.kms_key_arn
  } : null

  cluster_enabled_log_types               = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days  = 30

  # Minimal-cost node group (single small node). Consider t4g.small if you can use Arm images.
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

  # v20+ auth management
  # 1) Make the cluster creator an admin automatically (role/user running 'terraform apply')
  enable_cluster_creator_admin_permissions = true

  # 2) Optionally add an additional admin role via access_entries when admin_role_arn is set
  access_entries = length(var.admin_role_arn) > 0 ? {
    admin = {
      principal_arn = var.admin_role_arn
      # Optionally associate default admin policy
      policy_associations = [{
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type       = "cluster"
          namespaces = null
        }
      }]
      # You can also add kubernetes_groups if you prefer legacy mapping
      kubernetes_groups = ["system:masters"]
    }
  } : {}
  
  tags = var.tags
}

# Data sources used by providers in /infra/prod/providers.tf
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

output "cluster_name"      { value = module.eks.cluster_name }
output "cluster_endpoint"  { value = module.eks.cluster_endpoint }
output "oidc_provider_arn" { value = module.eks.oidc_provider_arn }
output "vpc_id"            { value = var.vpc_id }
