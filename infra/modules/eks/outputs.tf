#############################################
# EKS Module - Outputs
#############################################

output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint URL for the EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider (used for IRSA)."
  value       = module.eks.oidc_provider_arn
}

output "cluster_security_group_id" {
  description = "Security group ID for the EKS control plane."
  value       = try(module.eks.cluster_security_group_id, null)
}

output "node_security_group_id" {
  description = "Shared node security group ID for managed node groups."
  value       = try(module.eks.node_security_group_id, null)
}

output "managed_node_group_names" {
  description = "Names of created EKS managed node groups."
  value       = try(module.eks.eks_managed_node_groups_names, [])
}
