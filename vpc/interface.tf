variable "name" {
  description = "VPC name"
}

variable "cidr" {
  description = "VPC cidr"
}

variable "public_subnet" {
  description = "VPC public subnet"
}

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

output "vpc_id" {
  value = "${aws_vpc.name.id}"
}

output "cidr" {
  value = "${aws_vpc.name.cidr_block}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}
