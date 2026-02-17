terraform {
  # Allow any Terraform 1.x version (works with your 1.14.5)
  required_version = ">= 1.0, < 2.0"

  required_providers {
    aws        = { source = "hashicorp/aws", version = "~> 5.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.29" }
    helm       = { source = "hashicorp/helm", version = "~> 2.12" }
    random     = { source = "hashicorp/random", version = "~> 3.6" }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# These will be valid *after* the cluster exists—using try(...) avoids init-time evaluation errors
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = try(data.aws_eks_cluster.this.endpoint, null)
  cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.this.certificate_authority[0].data), null)
  token                  = try(data.aws_eks_cluster_auth.this.token, null)
}

provider "helm" {
  kubernetes {
    host                   = try(data.aws_eks_cluster.this.endpoint, null)
    cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.this.certificate_authority[0].data), null)
    token                  = try(data.aws_eks_cluster_auth.this.token, null)
  }
}
