provider "aws" {
  region = "us-west-2"
}

resource "aws_db_subnet_group" "oracle-subnet" {
  name = "oaracle-subnet"
  description = "RDS subnet group"
  subnet_ids = [ "${aws_subnet.main-private-1.id}", "${aws_subnet.main-private2.id}" ]
}
resource "aws_db_parameter_group" "oracle-prarameters" {
  name = "oracle-parameters"
  family = "oracle19.0"
  description = "oracle Db Parameters group"

  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "oracledb" {
  allocated_storage     = 20 
  engine                = "oracle-ee"
  engine_version        = "19.0.0.0"
  instance_class        = "db.m5.large"
  identifier            = "oracle"
  name                  = "awsiroracle01np"
  username              = "admin"
  password              = "admin"
  db_subnet_group_name  = "${aws_db_subnet_group.oracle-subnet.name}"
  parameter_group_name  = "oracle-prarameters"
  vpc_security_group_ids = [ "${aws_security_group.allow-oracle.id}"]
  storage_type = "gp2"
  availability_zone = "${aws_subnet.main-private-1.avaliability_zone}"
  tags {
      Name = "oracle-instance"
  }
}