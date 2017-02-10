provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source        = "./vpc"
  name          = "deep-learning"
  cidr          = "10.0.0.0/24"
  public_subnet = "10.0.0.0/28"
}

resource "aws_instance" "dl" {
  ami                         = "${lookup(var.ami, var.region)}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${module.vpc.public_subnet_id}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "128"
  }

  vpc_security_group_ids = [
    "${aws_security_group.dl_host_sg.id}",
  ]

  tags {
    Name = "${format("%03d", count.index+1)}-gpu-machine"
  }

  count = 1
}

resource "aws_security_group" "dl_host_sg" {
  name        = "DL host"
  description = "Allow SSH & IPython"
  vpc_id      = "${module.vpc.vpc_id}"

  # SSH access to the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # IPython access tp the VPC
  ingress {
    from_port   = 8888
    to_port     = 8898
    protocol    = "tcp"
    cidr_blocks = ["${module.vpc.cidr}"]
  }

  # ICMP Ping traffic
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
