output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_route_table_ids" {
  description = "Private route table IDs (optional, useful for debugging)"
  value       = try(module.vpc.private_route_table_ids, [])
}

output "public_route_table_ids" {
  description = "Public route table IDs (optional)"
  value       = try(module.vpc.public_route_table_ids, [])
}
