resource "aws_security_group" "gateway" {
  name   = "gateway"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "172.31.1.0/24",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2c"

  tags = {
    Name = "Subnet az 1a"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}
