output "addresses" {
  value = ["${aws_instance.dl.*.public_ip}"]
}
