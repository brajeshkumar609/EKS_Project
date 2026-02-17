terraform {
  backend "s3" {
    bucket       = "tfstate-brajesh-prod" # create once (unique name)
    key          = "envs/prod/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # S3 lockfile; DynamoDB locking is deprecated
  }
}
