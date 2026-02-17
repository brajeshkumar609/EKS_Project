variable "cluster_name" {
  type    = string
  default = "prod-eks"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_id" {
  type    = string
  default = "" # fill with module.vpc.vpc_id in stack
}

variable "oidc_provider_arn" {
  type    = string
  default = "" # required for IRSA; fill with module.eks.oidc_provider_arn
}

variable "alb_chart_version" {
  type    = string
  default = "1.7.1"
}

variable "tags" {
  type    = map(string)
  default = {
    Environment = "prod"
    Platform    = "eks"
  }
}
