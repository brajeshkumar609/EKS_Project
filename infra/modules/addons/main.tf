# Managed add-ons (optional pinning)
resource "aws_eks_addon" "vpc_cni" {
  cluster_name                 = var.cluster_name
  addon_name                   = "vpc-cni"
  resolve_conflicts_on_update  = "OVERWRITE"
}
resource "aws_eks_addon" "coredns" {
  cluster_name                 = var.cluster_name
  addon_name                   = "coredns"
  resolve_conflicts_on_update  = "OVERWRITE"
}
resource "aws_eks_addon" "kube_proxy" {
  cluster_name                 = var.cluster_name
  addon_name                   = "kube-proxy"
  resolve_conflicts_on_update  = "OVERWRITE"
}

# IRSA for AWS Load Balancer Controller
module "alb_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.39"

  role_name_prefix                     = "${var.cluster_name}-alb-"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    this = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
  tags = var.tags
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.alb_chart_version

  values = [
    yamlencode({
      clusterName = var.cluster_name
      region      = var.region
      serviceAccount = {
        create = true
        name   = "aws-load-balancer-controller"
        annotations = {
          "eks.amazonaws.com/role-arn" = module.alb_irsa.iam_role_arn
        }
      }
      vpcId = var.vpc_id
    })
  ]
}
