#############################################
# VPC Module - Variables
#############################################

variable "name" {
  description = "Base name used for VPC and subnet tags."
  type        = string
  default     = "prod-ap-south-1"
}

variable "cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "azs" {
  description = "Availability Zones to use."
  type        = list(string)
  # Keep 2 AZs for lower cost; you can expand to a third later.
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
  default     = ["10.20.0.0/20", "10.20.16.0/20"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets (one per AZ)."
  type        = list(string)
  default     = ["10.20.128.0/20", "10.20.144.0/20"]
}

variable "enable_nat_gateway" {
  description = "Create NAT gateway(s) for private subnets egress."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway (cheaper) instead of one per AZ."
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "If true, creates one NAT per AZ (expensive). Keep false for minimal cost."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    Environment = "prod"
    Platform    = "eks"
  }
}
