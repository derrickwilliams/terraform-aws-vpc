resource "aws_security_group" "privatevm" {
  name        = "private_vm"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "Bastion security group (only SSH inbound access is allowed)"

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    protocol  = -1
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "priv1" {
  ami                    = "ami-022b9262"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.private_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.privatevm.id}"]
  key_name               = "${var.iam_key_name}"
  count                  = 1

  tags {
    Name = "priv1"
  }
}

