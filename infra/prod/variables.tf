#############################################
# Prod Stack - Variables
#############################################

variable "cluster_name" {
  description = "EKS cluster name for the prod environment."
  type        = string
  default     = "prod-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the prod EKS cluster."
  type        = string
  default     = "1.29"
}
