terraform {
  backend "s3" {
    bucket         = "tfstate-prod-yourorg"
    key            = "eks/prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tfstate-locks"
    encrypt        = true
    kms_key_id     = "alias/tfstate-sse-kms"
  }
}
