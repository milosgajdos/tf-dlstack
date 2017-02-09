variable "region" {
  description = "AWS region"
}

variable "ami" {
  description = "AWS AMI map"
  type        = "map"

  default = {}
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "p2.xlarge"
}

variable "key_name" {
  description = "SSH key to use for login"
  default     = "awsceres"
}
