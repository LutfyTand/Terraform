provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_db_subnet_group" "lutung-private-subnet" {
  name       = "${var.rds_identifier}-subnet-group"
  subnet_ids = ["${var.rds_subnet1}", "${var.rds_subnet2}"]
}

resource "aws_security_group" "lutung-sg" {
  name   = "${var.rds_identifier}-rds-sg"
  vpc_id = "${var.vpc_id}"
  tags = {
    Name = "${var.rds_identifier}-rds-sg"
    Cost = "${var.tag_cost != "" ? var.tag_cost : "terraform"}"
    Env  = "${var.rds_env}"
  }
}

resource "aws_security_group_rule" "lutung_inbound_access" {
  from_port         = "${var.rds_engine == "postgres" ? 5432 : 3306}"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lutung-sg.id}"
  to_port           = "${var.rds_engine == "postgres" ? 5432 : 3306}"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "lutung_db_instance" {
  allocated_storage           = "${var.rds_allocated_storage}"
  storage_type                = "${var.rds_storage_type}"
  engine                      = "${var.rds_engine}"
  engine_version              = "${var.rds_engine_version}"
  instance_class              = "${var.db_instance}"
  identifier                  = "${var.rds_identifier}"
  name                        = "${var.rds_db_name}"
  username                    = "${var.rds_db_username}"
  password                    = "${var.rds_db_password}"
  parameter_group_name        = "${var.rds_parameter_group_name}"
  db_subnet_group_name        = "${aws_db_subnet_group.lutung-private-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.lutung-sg.id}"]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = "${var.rds_env == "Production" ? true : false}"
  skip_final_snapshot         = true
  publicly_accessible         = false
  deletion_protection         = "${var.rds_env == "Production" ? true : false}"

  tags = {
    Name = "${var.rds_identifier}"
    Cost = "${var.tag_cost != "" ? var.tag_cost : "terraform "}"
    Env  = "${var.rds_env}"
  }
}