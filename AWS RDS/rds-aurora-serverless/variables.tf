variable "aws_region" {
  default = "us-east-1"
}
variable "rds_cluster_identifier" {
  default = "terraform-devops"
}
variable "rds_env" {
  default = "Development" # Production, Demo, Development
}
variable "tag_cost" {
  default = ""            # optional if you want to split AWS billing with Cost Tag
}

# Engine options
variable "rds_cluster_engine_mode"{
  default = "serverless"  # for serverless only valid for Aurora MySQL 1.21 or earlier and Aurora PostgreSQL 10.12 or earlier
}
variable "rds_cluster_engine" {
  default = "aurora-mysql"
}
variable "rds_cluster_engine_version" {
  default = "5.7.mysql_aurora.2.03.2"
}

# Databases Settings
variable "rds_db_username" {
  default = "root"
}
variable "rds_db_password" {
  default = "lutung-devops"
}
variable "rds_db_name" {
  default = "lutung"
}
variable "min_capacity" {
  default = 1              # The valid scaling range for Aurora PostgreSQL is 2 to 384
}
variable "max_capacity" {
  default = 256    
}

# Connectivity
variable "vpc_id" {
  default = "vpc-049f32a2b26671965"
}
variable "az1" {
  default = "us-east-1a"
}
variable "rds_cluster_subnet1" {
  default = "subnet-0c8e13a"
}
variable "az2" {
  default = "us-east-1b"
}
variable "rds_cluster_subnet2" {
  default = "subnet-04c60d5"
}
variable "az3" {
  default = "us-east-1c"
}
variable "rds_cluster_subnet3" {
  default = "subnet-0ef5533"
}