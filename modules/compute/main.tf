# Look up the latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  k3s_user_data = <<-EOF
#!/bin/bash
set -euxo pipefail

apt-get update -y
apt-get install -y curl

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Create kubeconfig for the ubuntu user
mkdir -p /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config

# Set correct ownership and permissions
chown -R ubuntu:ubuntu /home/ubuntu/.kube
chmod 600 /home/ubuntu/.kube/config

# Make kubectl work automatically when ubuntu logs in
echo "export KUBECONFIG=/home/ubuntu/.kube/config" >> /home/ubuntu/.bashrc
EOF
}

# EC2 Instance
resource "aws_instance" "k3s_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_pair_name

  user_data = var.install_k3s ? local.k3s_user_data : null

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  volume_tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-root-volume"
  })

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-server"
  })
}