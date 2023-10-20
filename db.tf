resource "aws_db_instance" "rds" {
  allocated_storage           = 10
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  db_name                     = "mydb"
  username                    = "admin"
  manage_master_user_password = true
  parameter_group_name        = "default.mysql5.7"
  skip_final_snapshot         = true
  multi_az                    = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = "rds_subnet_group"

  tags = {
    Name = "RDSInstance"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.private_rds_subnets[*].id
  tags = {
    Name = "RDS Subnet Group"
  }
}
