provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.50.0"
    }
  }
}

## Variables declaration

variable "account_id" {
  type        = string
  description = "AWS Account id"

  validation {
    condition     = length(var.account_id) > 0
    error_message = "Empty AWS account id."
  }
}

variable "region" {
  type        = string
  description = "AWS region"

  validation {
    condition     = length(var.region) > 0
    error_message = "Empty region."
  }
}


variable "tag_value" {
  type        = string
  default     = ""
  description = ""
}

## Code to fetch details of EC2 instances

data "aws_instances" "instances" {
  instance_tags = {
    Name = var.tag_value
  }

  instance_state_names = ["running", "stopped"]
}


output "instances_ids" {
  value = data.aws_instances.instances.ids
}

output "instances_private_ips" {
  value = data.aws_instances.instances.private_ips
}

output "instances_public_ips" {
  value = data.aws_instances.instances.public_ips
}