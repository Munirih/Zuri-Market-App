module "network" {
  source = "./modules/network"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment
 
}

module "securitygroup" {
  source = "./modules/securitygroup"

  name          = var.sg_name
  vpc_id        = module.network.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "secret-manager" {
  source = "./modules/secret-manager"

  secret_name     = var.secret_name
  description     = var.description
  api_secret_key  = var.api_secret_key
  store_name      = var.store_name
} 

module "ec2-instance" {
  source  = "./modules/ec2-instance"

  vpc_id             = module.network.vpc_id
  subnet_id          = module.network.public_subnet_ids[0]
  ec2_name           = var.ec2_name
  ec2_instance_type  = var.ec2_instance_type
  ec2_key_name       = var.ec2_key_name
  security_group_id  = module.securitygroup.security_group_id
  environment        = var.environment
  
  secret_arn         = module.secret-manager.secret_arn
  iam_role           = var.iam_role
  iam_policy         = var.iam_policy
  instance_profile   = var.instance_profile


}