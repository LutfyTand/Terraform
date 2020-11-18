variable "aws_region" {
  default = "us-east-1"
}
variable "rds_identifier" {
  default = "terraform-devops"
}
variable "rds_env" {
  default = "Development" # Production, Demo, Development
}
variable "tag_cost" {
  default = "" # optional if you want to split AWS billing with Cost Tag
}

# Engine options
variable "rds_engine" {
  default = "mysql" # mysql, postgres or mariadb
}
variable "rds_engine_version" {
  default = "5.7"
}
variable "rds_parameter_group_name" {
  default = "default.mysql5.7"
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
variable "db_instance" {
  default = "db.t2.micro"
}
variable "rds_storage_type"{
  default = "gp2"
}
variable "rds_allocated_storage"{
  default = 20
}

# Connectivity
variable "vpc_id" {
  default = "vpc-049f32a2b26671965"
}
variable "rds_subnet1" {
  default = "subnet-04c60d5aca620606f"
}
variable "rds_subnet2" {
  default = "subnet-0ef5533496c7d61fb"
}