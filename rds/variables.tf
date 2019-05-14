variable "db_instance" {
  default = "db.t2.micro"
}

variable "rds_subnet1" {
  default = "subnet-30339257"
}

variable "rds_subnet2" {
  default = "subnet-9d384fd7"
}

variable "vpc_id" {
  default = "vpc-9e8963e4"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_engine_version" {
  default = "5.7"
}

variable "rds_identifier" {
  default = "terraformrds"
}

variable "rds_db_name" {
  default = "terraformrds"
}

variable "rds_db_username" {
  default = "devopscilsy"
}

variable "rds_db_password" {
  default = "1234567890"
}

variable "rds_parameter_group_name" {
  default = "default.mysql5.7"
}
