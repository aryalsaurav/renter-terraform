resource "aws_security_group" "rds" {
  name   = "${var.cluster_name}-rds-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_to_rds" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.eks_nodes.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "rds_outbound" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "eks_nodes" {
  name   = "${var.cluster_name}-nodes-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-nodes-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_all" {
  security_group_id = aws_security_group.eks_nodes.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "eks_nodes_self" {
  security_group_id            = aws_security_group.eks_nodes.id
  referenced_security_group_id = aws_security_group.eks_nodes.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cluster_to_nodes" {
  security_group_id            = aws_security_group.eks_nodes.id
  referenced_security_group_id = var.cluster_security_group_id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "nodes_to_cluster" {
  security_group_id            = var.cluster_security_group_id
  referenced_security_group_id = aws_security_group.eks_nodes.id

  ip_protocol = "-1"
}

resource "aws_security_group" "redis" {
  name   = "${var.cluster_name}-redis-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-redis-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "redis" {
  security_group_id = aws_security_group.redis.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "redis" {
  security_group_id            = aws_security_group.redis.id
  referenced_security_group_id = aws_security_group.eks_nodes.id

  from_port   = 6379
  to_port     = 6379
  ip_protocol = "tcp"
}