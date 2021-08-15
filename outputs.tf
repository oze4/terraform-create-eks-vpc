output "eks" {
  description = "EKS Cluster"
  value = module.eks
}

output "vpc" {
  description = "VPC Info"
  value = module.vpc
}