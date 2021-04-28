resource "aws-security_group" "example-instance" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-ssh"
  egress {
      from_port = 0
      to_port =0
      protocol = "-1"
      cidr_block = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = ["0.0.0.0/0"]
  }
  tags {
      Name = "example-instance"
  }
}

resource "aws_security_group" "allow-oracle" {
  vpc_id = "${aws_vpc.id}"
  name = "allow-oracle"
  ingress = {
    from_port = 1521
    to_port = 1521
    protocol = "tcp"
    security_groups = ["${aws_security_group.example-instance.id}" ]
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
    self = true
  }
  tags {
      Name = "allow-oracles"
  }
}