# ── Provider ─────────────────────────────────────────────────

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 remote backend
  # This replaces the local terraform.tfstate file.
  # Terraform state will be stored in S3 and locked using DynamoDB.
  backend "s3" {
    bucket         = "terraform-state-amdari"
    key            = "terraform-k3s/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# ── Networking Module ─────────────────────────────────────────
# Creates the VPC, subnet, internet gateway, route table,
# route table association, and security group.

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  common_tags  = local.common_tags
}

# ── Compute Module ────────────────────────────────────────────
# Creates the EC2 instance and optionally installs K3s.
# subnet_id and security_group_id come from the networking module outputs.

module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  environment       = var.environment
  instance_type     = local.instance_type
  key_pair_name     = var.key_pair_name
  subnet_id         = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
  volume_size       = local.volume_size
  install_k3s       = var.install_k3s
  common_tags       = local.common_tags
}