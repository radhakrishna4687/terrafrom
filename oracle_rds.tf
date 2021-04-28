provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "my-test-orcale" {
  #instance_class          = "db.m5.large"
  engine                  = "oracle-ee"
  engine_version          = "19.0"
  multi_az                = false
  storage_type            = "gp2"
  allocated_storage       = 20
  name                    = "awsiroracle01np"
  username                = "admin"
  password                = "admin"
  db_subnet_group_name    = "${aws_db_subnet_group.my-rds-db-subnet.name}"
  vpc_security_group_ids  = ["${aws_security_group.my-rds-sg.id}"]
}

resource "aws_db_subnet_group" "my-rds-db-subnet" {
  name       = "my-rds-db-subnet"
  subnet_ids = ["${var.public_cidrs_1}"]
}

resource "aws_security_group" "my-rds-sg" {
  name   = "my-rds-sg"
  vpc_id = "${var.vpc_cidr}"
}

resource "aws_security_group_rule" "my-rds-sg-rule" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.my-rds-sg.id}"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.my-rds-sg.id}"
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

#output 
output "db_end_point" {
    value = aws_db_instance.my-test-orcale.endpoint
}
