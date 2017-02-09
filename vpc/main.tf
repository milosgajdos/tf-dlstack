resource "aws_vpc" "name" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "name" {
  vpc_id = "${aws_vpc.name.id}"

  tags {
    Name = "${var.name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.name.id}"
  cidr_block = "${var.public_subnet}"

  tags {
    Name = "${var.name}-subnet"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_vpc.name.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.name.id}"
}
