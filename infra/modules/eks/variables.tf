variable "cluster_name" {
  type    = string
  default = "prod-eks"
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "vpc_id" {
  type    = string
  default = "" # fill with module.vpc.vpc_id in stack
}

variable "private_subnet_ids" {
  type    = list(string)
  default = [] # fill with module.vpc.private_subnets in stack
}

variable "kms_key_arn" {
  type    = string
  default = "" # optional; leave empty to skip secrets encryption
}

variable "admin_role_arn" {
  type    = string
  default = "" # map your IAM admin role; empty means no extra aws-auth mappings
}

variable "tags" {
  type    = map(string)
  default = {
    Environment = "prod"
    Platform    = "eks"
  }
}
