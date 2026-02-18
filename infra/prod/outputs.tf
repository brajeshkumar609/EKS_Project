#############################################
# Prod Stack - Outputs (NO ADD-ONS)
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
  description = "Public subnet IDs (useful for testing/ALB if added later)."
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
