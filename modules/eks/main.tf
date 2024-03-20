# EKS Module


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    eks-cluster-ng = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.micro"]
      capacity_type  = "ON_DEMAND"

     
    }
  }

}