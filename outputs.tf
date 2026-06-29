# ── Compute Outputs ───────────────────────────────────────────

output "server_public_ip" {
  description = "Public IP address of the server"
  value       = module.compute.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.instance_id
}

output "server_private_ip" {
  description = "Private IP address of the server"
  value       = module.compute.private_ip
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh -i $env:USERPROFILE\\.ssh\\${var.key_pair_name}.pem ubuntu@${module.compute.public_ip}"
}

output "app_url" {
  description = "URL to access K3s NodePort apps"
  value       = "http://${module.compute.public_ip}:30080"
}

output "k3s_api_url" {
  description = "K3s Kubernetes API endpoint"
  value       = "https://${module.compute.public_ip}:6443"
}

# ── Networking Outputs ────────────────────────────────────────

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "subnet_id" {
  description = "Public subnet ID"
  value       = module.networking.subnet_id
}

output "security_group_id" {
  description = "K3s security group ID"
  value       = module.networking.security_group_id
}

# ── Environment Outputs ───────────────────────────────────────

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "terraform_workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}