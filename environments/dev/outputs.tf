output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_secret_name" {
  value = module.databases.rds_secret_name
}

output "github_action_role_arn" {
  value = module.iam.github_action_role_arn
}

output "repository_url" {
  value = module.ecr.repository_url
}