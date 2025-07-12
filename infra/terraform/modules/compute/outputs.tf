output "ec2_ids" {
  value = aws_instance.web[0].id
}

output "public_ip" {
  value = aws_instance.web[*].public_ip
}

output "key_pair_name" {
  value = var.public_key_path != "" ? aws_key_pair.main[0].key_name : var.key_pair_name
}
