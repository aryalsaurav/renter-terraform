resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids              = values(var.private_subnet_ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = false # need to change to false in next create destroy 
  }

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eks_access_entry" "cluster_admin" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = var.cluster_admin_principal_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "cluster_admin" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = var.cluster_admin_principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_launch_template" "nodes" {
  name_prefix            = "${var.cluster_name}-nodes-"
  vpc_security_group_ids = [var.eks_nodes_sg_id]
}
resource "aws_eks_node_group" "main" {
  cluster_name  = aws_eks_cluster.main.name
  node_role_arn = var.node_role_arn

  subnet_ids     = values(var.private_subnet_ids)
  instance_types = var.node_instance_types

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  launch_template {
    id      = aws_launch_template.nodes.id
    version = aws_launch_template.nodes.latest_version
  }

  capacity_type = "ON_DEMAND"

  tags = {
    Name = "${var.cluster_name}-nodes"
  }

}


resource "aws_eks_addon" "main" {
  for_each = var.eks_addons

  cluster_name  = aws_eks_cluster.main.name
  addon_name    = each.key
  addon_version = each.value.addon_version

  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.main
  ]
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = var.ebs_csi_role_arn
}

resource "aws_eks_pod_identity_association" "external_secrets" {
  cluster_name    = aws_eks_cluster.main.name
  service_account = "external-secrets"
  namespace       = "external-secrets"
  role_arn        = var.external_secrets_role_arn
}