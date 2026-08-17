module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  single_nat_gateway = true


}


module "iam" {
  source = "../../modules/iam"

  cluster_name = var.cluster_name
  github_repo  = var.github_repo
  ecr_repo_arn = module.ecr.repository_arn
}


module "eks" {
  source = "../../modules/eks"

  cluster_name                = var.cluster_name
  cluster_version             = var.cluster_version
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  node_desired_size           = var.node_desired_size
  node_min_size               = var.node_min_size
  node_max_size               = var.node_max_size
  node_instance_types         = var.node_instance_types
  cluster_role_arn            = module.iam.cluster_role_arn
  node_role_arn               = module.iam.node_role_arn
  ebs_csi_role_arn            = module.iam.ebs_csi_role_arn
  cluster_admin_principal_arn = var.cluster_admin_principal_arn
  eks_addons                  = var.eks_addons
  eks_nodes_sg_id             = module.security.eks_nodes_sg_id
}


module "ecr" {
  source = "../../modules/ecr"

  ecr_repository_name = var.ecr_repository_name
}


module "databases" {
  source = "../../modules/databases"

  identifier        = var.rds_identifier
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage

  private_subnet_ids = module.vpc.private_subnet_ids

  database_name   = var.rds_database_name
  master_username = var.rds_master_username
  rds_sg_id       = module.security.rds_sg_id

  multi_az                = var.rds_multi_az
  backup_retention_period = var.rds_backup_retention_period
  deletion_protection     = var.rds_deletion_protection
  skip_final_snapshot     = var.rds_skip_final_snapshot

  redis_engine_version = var.redis_engine_version
  replication_group_id = var.redis_replication_group_id
  redis_sg_id          = module.security.redis_sg_id
  node_type            = var.redis_node_type
  num_cache_clusters   = var.redis_num_cache_clusters
}


module "security" {
  source = "../../modules/security"

  vpc_id                    = module.vpc.vpc_id
  cluster_name              = var.cluster_name
  cluster_security_group_id = module.eks.cluster_security_group_id
}