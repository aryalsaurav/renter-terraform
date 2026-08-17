variable "cluster_name" {
  type = string
}

variable "github_repo" {
  type    = string
  default = "repo:aryalsaurav/renter:ref:refs/heads/main"

}

variable "ecr_repo_arn" {
  type = string
}

variable "rds_secret_arn" {
  type = string
}

variable "application_secret_arn" {
  type = string
}

variable "storage_bucket_arn" {
  type = string
}