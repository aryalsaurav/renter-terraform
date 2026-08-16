variable "vpc_name" {
  type    = string
  default = "eks-renter-dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/8"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT Gateway for all private subnets."
  type        = bool
  default     = true
}