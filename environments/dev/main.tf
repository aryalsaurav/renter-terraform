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
}


module "ecr" {
  source = "../../modules/ecr"

  ecr_repository_name = var.ecr_repository_name
}

