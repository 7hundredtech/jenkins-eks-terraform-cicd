
# VPC Module

data "aws_availability_zones" "azs" {}
module "vpc" {
 source  = "terraform-aws-modules/vpc/aws"
 version = "~> 4.0"
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                 = data.aws_availability_zones.azs.names
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

 public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

 private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = var.enable_flow_log
  create_flow_log_cloudwatch_log_group = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role  = var.create_flow_log_cloudwatch_iam_role 
  flow_log_max_aggregation_interval    = 60

  

}
