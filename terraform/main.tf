module "network" {
  source = "./modules/network"

  vpc_name             = "k3s"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  environment          = "prod"
 
}

module "securitygroup" {
  source = "./modules/securitygroup"

  name          = "k3s-server-sg"
  vpc_id        = module.network.vpc_id
  ingress_rules = [
  {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Custom TCP for Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow NodePort traffic"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
  
  egress_rules  = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
}

data "aws_secretsmanager_secret" "store" {
  name = "zuri-app-secrets"
}

module "ec2-instance" {
  source  = "./modules/ec2-instance"

  vpc_id             = module.network.vpc_id
  subnet_id          = module.network.public_subnet_ids[0]
  ec2_name           = "k3s-server"
  ec2_instance_type  = "c7i-flex.large"
  ec2_key_name       = var.ec2_key_name
  security_group_id  = module.securitygroup.security_group_id
  environment        = "prod"
  
  secret_arn         = data.aws_secretsmanager_secret.store.arn
  iam_role           = "zuriapp-ec2-role"
  iam_policy         = "zuriapp-secrets-policy"
  instance_profile   = "zuriapp-ec2-profile"

}