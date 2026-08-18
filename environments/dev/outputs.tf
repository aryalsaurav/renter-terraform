output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_secret_name" {
  value = module.databases.rds_secret_name
}