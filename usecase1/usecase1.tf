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

## Code for creating s3 for deploying web application
resource "aws_s3_bucket" "b" {
  bucket = "s3-website-test.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

## Creating EC2 for application layer
data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "Dummy"
  }
}

## Creating RDS instance for database(MySQl)

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "test"
  password             = "test@123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}