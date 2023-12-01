//AWS Region
variable "aws_region" {
  default = "us-east-1"
}
//RDS Variables
variable "rds_instance_name" {
  type = string
  default = "main-instance-compute"
}
variable "rds_instance_username" {
  type = string
}
// GLUE Variables
variable "pwd_rds_instance" {
  type = string
}
