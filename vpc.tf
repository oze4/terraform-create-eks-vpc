variable "region" {
  default     = "us-west-1"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = var.vpc.name
  cidr                 = var.vpc.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.vpc.private_subnets
  public_subnets       = var.vpc.public_subnets
  enable_nat_gateway   = var.vpc.enable_nat_gateway
  single_nat_gateway   = var.vpc.single_nat_gateway
  enable_dns_hostnames = var.vpc.enable_dns_hostnames

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster.name}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster.name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster.name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }
}
