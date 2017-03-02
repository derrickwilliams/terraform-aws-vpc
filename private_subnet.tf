resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "172.31.2.0/24"
  availability_zone = "us-west-2c"
  tags = {
  	Name =  "Subnet private 1 az 1a"
  }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "Private route table"
    }
}

resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = "${aws_subnet.private_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.public_eip.id}"
    subnet_id = "${aws_subnet.private_subnet.id}"
    depends_on = ["aws_internet_gateway.gw"]
}
