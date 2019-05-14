provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "rds-private-subnet" {
  name       = "rds-private-subnet-group"
  subnet_ids = ["${var.rds_subnet1}", "${var.rds_subnet2}"]
}

resource "aws_security_group" "rds-sg" {
  name   = "my-rds-sg"
  vpc_id = "${var.vpc_id}"
}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.rds-sg.id}"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "devops_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "${var.rds_engine}"
  engine_version              = "${var.rds_engine_version}"
  instance_class              = "${var.db_instance}"
  identifier                  = "${var.rds_identifier}"
  name                        = "${var.rds_db_name}"
  username                    = "${var.rds_db_username}"
  password                    = "${var.rds_db_password}"
  parameter_group_name        = "${var.rds_parameter_group_name}"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.rds-sg.id}"]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}
