locals {
  region                               = "us-east-2"
  vpc_name                             = "eks-vpc"
  vpc_cidr                             = "10.0.0.0/16"
  private_subnets                      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets                       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_nat_gateway                   = true
  single_nat_gateway                   = true
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  cluster_name                         = "myeks-cluster"

}