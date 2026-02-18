#############################################
# EKS Module - Outputs (NO ADD-ONS)
#############################################

output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint URL."
  value       = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  description = "EKS OIDC provider ARN (IRSA)."
  value       = module.eks.oidc_provider_arn
}

output "cluster_security_group_id" {
  description = "Control plane security group ID."
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
