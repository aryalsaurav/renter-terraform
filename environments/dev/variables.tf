variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "eks-renter-dev"
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

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_desired_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_instance_types" {
  type = list(string)
}

variable "cluster_admin_principal_arn" {
  description = "IAM principal used for EKS cluster administration."
  type        = string
}

variable "eks_addons" {
  type = map(object({
    addon_version = string
  }))
}

variable "ecr_repository_name" {
  type    = string
  default = "renter"
}

variable "github_repo" {
  type    = string
  default = "repo:aryalsaurav/renter:ref:refs/heads/main"

}
variable "rds_identifier" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}
variable "rds_database_name" {
  type = string
}

variable "rds_master_username" {
  type = string
}

variable "rds_multi_az" {
  type = bool
}

variable "rds_backup_retention_period" {
  type = number
}

variable "rds_deletion_protection" {
  type = bool
}

variable "rds_skip_final_snapshot" {
  type = bool
}



variable "redis_replication_group_id" {
  description = "Redis replication group identifiers"
  type        = string
}

variable "redis_engine_version" {
  type = string
}

variable "redis_node_type" {
  type = string
}

variable "redis_num_cache_clusters" {
  type = number
}

variable "redis_port" {
  type    = number
  default = 6379
}


variable "application_secret_name" {
  type    = string
  default = "renter-dev"
}