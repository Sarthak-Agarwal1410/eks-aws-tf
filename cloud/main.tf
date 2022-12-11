module "iam" {
  source      = "../modules/iam"
  environment = var.name
}

module "key" {
  source = "../modules/keys"
  name   = var.name
}

module "vpc" {
  source               = "../modules/vpc"
  name                 = var.name
  k8s_cidr_block       = var.k8s_cidr_block
  subnet_cidr_block_1a = var.subnet_cidr_block_1a
  subnet_cidr_block_1b = var.subnet_cidr_block_1b
  subnet_cidr_block_1c = var.subnet_cidr_block_1c
  k8s_subnets          = module.vpc.k8s_subnet_ids
}

module "eks" {
  source            = "../modules/eks"
  name              = var.name
  role_arn          = module.iam.iam_role_arn
  k8s_subnets       = module.vpc.k8s_subnet_ids
  kubernetes_vpc_id = module.vpc.kubernetes_vpc_id
  k8s_cidr_block    = var.k8s_cidr_block
  region            = var.region
  sshkey            = module.key.key_name
  instancetype      = var.instancetype
  scalemin          = var.scalemin
  scalemax          = var.scalemax
  scaledesired      = var.scaledesired
  node_count        = var.node_count
  depends_on        = [module.iam, module.key]
}
