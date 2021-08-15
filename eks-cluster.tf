module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster.name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets
  tags            = var.eks_cluster.tags
  vpc_id          = module.vpc.vpc_id
  worker_groups = [
    {
      name                          = "eks_worker_group_00"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.eks_worker_group_00.id]
    },
    {
      name                          = "eks_worker_group_01"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.eks_worker_group_01.id]
      asg_desired_capacity          = 1
    },
  ]
  workers_group_defaults = {
    root_volume_type = "gp2"
  }
  //worker_groups = var.eks.worker_groups
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
