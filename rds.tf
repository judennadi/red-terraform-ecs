# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# launch an rds instance from a database snapshot
resource "aws_db_instance" "database_instance" {
  allocated_storage      = 10
  storage_type           = "gp2"
  db_name                = var.db_name
  engine                 = "postgres"
  identifier             = "${var.project_name}-${var.environment}-db"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
}

# # get information about a database snapshot
# data "aws_db_snapshot" "latest_db_snapshot" {
#   db_snapshot_identifier =
#   most_recent            = 
#   snapshot_type          = 
# }

# # launch an rds instance from a database snapshot
# resource "aws_db_instance" "database_instance" {
#   instance_class         = 
#   skip_final_snapshot    = 
#   availability_zone      = 
#   identifier             = 
#   snapshot_identifier    = 
#   db_subnet_group_name   = 
#   multi_az               = 
#   vpc_security_group_ids = 
# }
