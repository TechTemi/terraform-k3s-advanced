variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
}

variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "aws_region" {
  description = "AWS region used to select the availability zone"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to networking resources"
  type        = map(string)
}