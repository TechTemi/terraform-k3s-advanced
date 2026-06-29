locals {
  # Use a larger instance in prod, smaller in dev.
  # Keep t3 instead of t2 because K3s can struggle on t2.micro.
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t3.small"

  # Use a larger root disk in prod.
  volume_size = terraform.workspace == "prod" ? 30 : 20

  # Common tags for resources.
  common_tags = {
    Project     = var.project_name
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Week        = "Week16Lab"
    UpdatedBy   = "GitHubActions"
  }
}