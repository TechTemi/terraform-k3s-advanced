# Dev environment — small, cheap, safe to experiment with

project_name = "terraform-k3s"
environment  = "dev"
aws_region   = "us-west-2"

key_pair_name = "terraform-lab-key"

vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

install_k3s = true