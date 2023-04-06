terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }

  required_version = ">= 1.1.5"
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-{%- if cookiecutter.ami_distro == 'Ubuntu - Jammy' %}jammy-22.04{% else %}focal-20.04{%- endif %}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "prod_{{ cookiecutter.project_slug_simple }}_kp" {
  key_name   = "prod_kp"
  public_key = file("prod_kp.pub")
}
