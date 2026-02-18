#############################################
# EKS Module - Variables
#############################################

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "prod-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster."
  type        = string
  default     = "1.29"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be created."
  type        = string
  default     = "" # Pass from VPC module at the stack layer.
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by EKS control plane and nodes."
  type        = list(string)
  default     = [] # Pass from VPC module at the stack layer.
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for secrets encryption. Leave empty to disable."
  type        = string
  default     = ""
}

variable "admin_role_arn" {
  description = "Optional IAM role ARN to grant cluster-admin via access entries."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags for EKS resources."
  type        = map(string)
  default = {
    Environment = "prod"
    Platform    = "eks"
  }
}
