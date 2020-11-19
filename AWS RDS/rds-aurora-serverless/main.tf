provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_db_subnet_group" "lutung-cluster-subnet" {
  name       = "${var.rds_cluster_identifier}-subnet-group"
  subnet_ids = ["${var.rds_cluster_subnet1}", "${var.rds_cluster_subnet2}", "${var.rds_cluster_subnet3}"]
}

resource "aws_security_group" "lutung-cluster-sg" {
  name   = "${var.rds_cluster_identifier}-rds-sg"
  vpc_id = "${var.vpc_id}"
  tags = {
    Name = "${var.rds_cluster_identifier}-rds-sg"
    Cost = "${var.tag_cost != "" ? "${var.tag_cost}" : "terraform "}"
    Env  = "${var.rds_env}"
  }
}

resource "aws_security_group_rule" "lutung_inbound_access_cluster" {
  from_port         = "${var.rds_cluster_engine == "aurora-postgresql" ? 5432 : 3306}"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lutung-cluster-sg.id}"
  to_port           = "${var.rds_cluster_engine == "aurora-postgresql" ? 5432 : 3306}"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_rds_cluster" "lutung_db_cluster" {
  engine_mode                 = "${var.rds_cluster_engine_mode}"
  cluster_identifier          = "${var.rds_cluster_identifier}"
  engine                      = "${var.rds_cluster_engine}"
  engine_version              = "${var.rds_cluster_engine_version}"
  availability_zones          = ["${var.az1}", "${var.az2}", "${var.az3}"]
  database_name               = "${var.rds_db_name}"
  master_username             = "${var.rds_db_username}"
  master_password             = "${var.rds_db_password}"
  db_subnet_group_name        = "${aws_db_subnet_group.lutung-cluster-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.lutung-cluster-sg.id}"]
  backup_retention_period     = "${var.rds_env == "Production" ? 35 : 0}"
  apply_immediately           = true
  copy_tags_to_snapshot       = true
  final_snapshot_identifier   = "${var.rds_env == "Production" ? "${var.rds_cluster_identifier}-finalsnaphot" : "DELETE-ME"}" 
  skip_final_snapshot         = "${var.rds_env == "Production" ? false : true}"
  deletion_protection         = "${var.rds_env == "Production" ? true : false}"

  tags = {
    Name = "${var.rds_cluster_identifier}"
    Cost = "${var.tag_cost != "" ? "${var.tag_cost}" : "terraform "}"
    Env  = "${var.rds_env}"
  }

  scaling_configuration {
    auto_pause               = true
    max_capacity             = "${var.max_capacity}"
    min_capacity             = "${var.min_capacity}"
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}