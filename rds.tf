resource "aws_kms_key" "kms_key_main" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "rds_instance_main" {
  allocated_storage             = 10
  identifier                    = var.rds_instance_name
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.7"
  instance_class                = "db.t2.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.kms_key_main.key_id
  username                      = var.rds_instance_username
  parameter_group_name          = "default.mysql5.7"
  db_subnet_group_name          = aws_db_subnet_group.main_subnet_group_compute.name
  skip_final_snapshot           = true
  backup_retention_period       = 0
  apply_immediately             = true
}