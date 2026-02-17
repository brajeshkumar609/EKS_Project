#############################################
# Prod Stack - Outputs
#############################################

# Network
output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by EKS."
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnet IDs (e.g., for ALB)."
  value       = module.vpc.public_subnets
}

# EKS
output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint URL."
  value       = module.eks.cluster_endpoint
}

output "eks_oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA."
  value       = module.eks.oidc_provider_arn
}

output "eks_node_group_names" {
  description = "Names of EKS managed node groups."
  value       = try(module.eks.managed_node_group_names, [])
}

# Add-ons (if you surface them from the addons module)
output "aws_lbc_irsa_role_arn" {
  description = "IRSA role ARN for AWS Load Balancer Controller."
  value       = try(module.addons.aws_load_balancer_controller_role_arn, null)
}

output "aws_lbc_release_name" {
  description = "Helm release name for AWS Load Balancer Controller."
  value       = try(module.addons.aws_load_balancer_controller_release, null)
}
