output "public_ip" {
  description = "Public IP to SSH/Ansible into the instance and test nginx in browser"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "Convenience SSH command (replace .pem path)"
  value       = "ssh -i /path/to/your-key.pem ec2-user@${aws_instance.web.public_ip}"
}

output "instance_id" {
  value = aws_instance.web.id
}
