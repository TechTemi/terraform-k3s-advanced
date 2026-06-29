output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.k3s_server.public_ip
}

output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.k3s_server.id
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.k3s_server.private_ip
}

output "ssh_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i <your-key-file>.pem ubuntu@${aws_instance.k3s_server.public_ip}"
}

output "k3s_api_url" {
  description = "K3s Kubernetes API endpoint"
  value       = "https://${aws_instance.k3s_server.public_ip}:6443"
}