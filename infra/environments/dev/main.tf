module "network" {
  source = "../../modules/network"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
  az_count     = var.az_count
}


module "iam" {
  source = "../../modules/iam"

  project_name    = var.project_name
  environment     = var.environment
  oidc_issuer_url = module.eks.oidc_issuer_url

}

module "eks" {
  source = "../../modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  
  api_allowed_cidrs = [local.my_ip_cidr]

  # from network
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids

  # from iam
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  ebs_csi_role_arn = module.iam.ebs_csi_role_arn

  # node group sizing
  node_instance_types = ["t3.micro"]
  node_disk_size      = 20
  node_min_size       = 1
  node_desired_size   = 2
  node_max_size       = 3
}

module "storage" {
  source = "../../modules/storage"

  # wait for the cluster, nodes and EBS CSI addon
  depends_on = [module.eks]
}