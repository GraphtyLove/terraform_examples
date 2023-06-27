output "ip_address" {
  value = aws_eip.ec2_public_ip.public_ip
  description = "The public IP address of the instance"
}