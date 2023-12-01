// VPC
resource "aws_vpc" "main_vpc_compute" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "main-vpc-compute"
    Environment = "Dev"
  }
}

// SUBNET
resource "aws_subnet" "main_subnet_compute" {
  vpc_id            = aws_vpc.main_vpc_compute.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "main-subnet-compute"
    Environment = "Dev"
  }
}

resource "aws_subnet" "backup_subnet_compute" {
  vpc_id            = aws_vpc.main_vpc_compute.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Name        = "backup-subnet-compute"
    Environment = "Dev"
  }
}

// SUBNET GROUP
resource "aws_db_subnet_group" "main_subnet_group_compute" {
  name       = "main"
  subnet_ids = [aws_subnet.main_subnet_compute.id, aws_subnet.backup_subnet_compute.id]

  tags = {
    Name        = "main-subnet-group-compute"
    Environment = "Dev"
  }
}