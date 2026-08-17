resource "aws_db_subnet_group" "main" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = values(var.private_subnet_ids)

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name                     = var.database_name
  username                    = var.master_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible     = false
  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period
  storage_encrypted       = true

  deletion_protection = var.deletion_protection

  skip_final_snapshot = var.skip_final_snapshot

}


resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.replication_group_id}-subnet-group"
  subnet_ids = values(var.private_subnet_ids)

  tags = {
    Name = "${var.replication_group_id}-subnet-group"
  }
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id = var.replication_group_id
  description          = "Redis"

  engine         = "redis"
  engine_version = var.redis_engine_version

  node_type          = var.node_type
  num_cache_clusters = var.num_cache_clusters
  port               = var.redis_port

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [var.redis_sg_id]

  automatic_failover_enabled = false

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  tags = {
    Name = var.replication_group_id
  }

}