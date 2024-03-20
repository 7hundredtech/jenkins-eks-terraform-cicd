#Vpc Module
module "vpc" {
  source                               = "./modules/vpc"
  vpc_name                             = local.vpc_name
  vpc_cidr                             = local.vpc_cidr
  private_subnets                      = local.private_subnets
  public_subnets                       = local.public_subnets
  enable_dns_hostnames                 = local.enable_dns_hostnames
  enable_dns_support                   = local.enable_dns_support
  enable_nat_gateway                   = local.enable_nat_gateway
  single_nat_gateway                   = local.single_nat_gateway
  enable_flow_log                      = local.enable_flow_log
  create_flow_log_cloudwatch_log_group = local.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role  = local.create_flow_log_cloudwatch_iam_role
}


module "eks" {
  source          = "./modules/eks"
  cluster_name    = local.cluster_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}