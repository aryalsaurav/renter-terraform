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