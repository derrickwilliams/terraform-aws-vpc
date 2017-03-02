resource "aws_security_group" "bastion" {
  name        = "bastion"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "Bastion security group (only SSH inbound access is allowed)"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "bastion" {
  ami                    = "ami-022b9262"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  key_name = "${var.iam_key_name}"
  count                  = 1
  tags {
        Name = "bastion"
    }
}
