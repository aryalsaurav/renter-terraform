variable "identifier" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "backup_retention_period" {
  type = number
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

variable "rds_sg_id" {
  type = string
}



variable "replication_group_id" {
  description = "Redis replication group identifiers"
  type        = string
}

variable "redis_engine_version" {
  type = string
}

variable "node_type" {
  type = string
}

variable "num_cache_clusters" {
  type = number
}

variable "redis_sg_id" {
  type = string
}

variable "redis_port" {
  type    = number
  default = 6379
}