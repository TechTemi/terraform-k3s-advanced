locals {
  # Use a larger instance in prod, smaller in dev.
  # terraform.workspace is a built-in value that holds the
  # current workspace name, for example: dev or prod.
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t3.small"

  # Use a larger root disk in prod.
  volume_size = terraform.workspace == "prod" ? 30 : 20

  # Common tags for resources.
  common_tags = {
    Project     = var.project_name
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Week        = "Week16Lab"
  }
}