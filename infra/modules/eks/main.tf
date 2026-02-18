module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Endpoint access:
  # - Private = true lets you manage from EC2 in the VPC (secure, what you use now).
  # - Public  = false keeps API private. Set true if you want to access from internet.
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  public_access_cidrs = ["34.239.118.255/32"] # only if public access is enabled

  # IRSA (safe to leave on even if you don't use it immediately)
  enable_irsa = true

  # ----- Secrets encryption (KMS) -----
  # Minimal cost: don't create a CMK and don't enable encryption config.
  create_kms_key            = false
  cluster_encryption_config = var.kms_key_arn != "" ? [{
    resources        = ["secrets"]
    provider_key_arn = var.kms_key_arn
  }] : []

  # Control plane logs (low cost, useful for troubleshooting)
  cluster_enabled_log_types              = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = 30

  # One small node group (minimal cost)
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

  # v20+ authentication/authorization
  # Makes the cluster creator (your current CLI identity) a cluster-admin.
  enable_cluster_creator_admin_permissions = true

  # OPTIONAL: grant another IAM role admin access (remove this whole block if not needed)
  # Only keep if var.admin_role_arn is set to a real role.
  access_entries = length(var.admin_role_arn) > 0 ? {
    admin = {
      principal_arn = var.admin_role_arn
      policy_associations = [{
        policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = { type = "cluster", namespaces = null }
      }]
      kubernetes_groups = ["system:masters"]
    }
  } : {}

  tags = var.tags
}

# Outputs are best kept in a separate outputs.tf at the module level;
# if you already created that, don't duplicate them here.
