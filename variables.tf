variable "eks_cluster" {
  description = "EKS Cluster"

  type = object({
    name          = string
    worker_groups = list(object({}))
    tags          = object({})
  })

  default = {
    name          = "eks-00"
    worker_groups = []
    tags          = {}
  }
}

variable "vpc" {
  description = "VPC Params"

  type = object({
    name                 = string
    cidr                 = string
    private_subnets      = list(string)
    public_subnets       = list(string)
    enable_nat_gateway   = bool
    single_nat_gateway   = bool
    enable_dns_hostnames = bool
    tags                 = object({})
    public_subnet_tags   = object({})
    private_subnet_tags  = object({})
  })

  default = {
    name                 = "vpc-00"
    cidr                 = "10.0.0.0/16"
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
    enable_dns_hostnames = true
    single_nat_gateway   = true
    enable_nat_gateway   = true
    tags                 = {}
    public_subnet_tags   = {}
    private_subnet_tags  = {}
  }
}
