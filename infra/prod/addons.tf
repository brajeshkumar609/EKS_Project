module "addons" {
  source = "../modules/addons"

  cluster_name      = module.eks.cluster_name
  region            = "ap-south-1"
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn

  alb_chart_version = "1.7.1" # pin a known-good version

  tags = { Environment = "prod", Platform = "eks" }
}
