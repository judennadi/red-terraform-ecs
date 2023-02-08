resource "aws_elasticache_subnet_group" "cache_subnet_group" {
  name        = "${var.project_name}-${var.environment}-cache-subnets"
  subnet_ids  = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  description = "subnets for cache instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-cache-subnets"
  }
}

resource "aws_elasticache_cluster" "cache_instance" {
  cluster_id           = "${var.project_name}-${var.environment}-cache"
  engine               = "redis"
  engine_version       = "7.0"
  parameter_group_name = "default.redis7"
  node_type            = "cache.t2.micro"
  port                 = 6379
  num_cache_nodes      = 1
  security_group_ids   = [aws_security_group.cache_security_group.id]
  subnet_group_name    = aws_elasticache_subnet_group.cache_subnet_group.name
}
