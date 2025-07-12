# ================== Providers ==================
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ================== Modules ==================
module "network" {
  source = "../../modules/network"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = var.vpc_name
  enable_dns     = var.enable_dns
  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  
}

module "security" {
  source = "../../modules/security"

  vpc_id     = module.network.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "compute-WebApp" {
  source = "../../modules/compute"
  
  instance_name			 = "TF-eShopApp"
  instance_count         = "1"
  key_pair_name          = "eshoponweb-key"
  public_key_path		 = var.public_key_path
  instance_type          = var.instance_type
  ami_id                 = var.ami_id
  user_data              = file("./../../modules/compute/user_data.sh") 
  public_subnet_id       = module.network.public_subnet_ids[0]
  sg_ids  			     = module.security.security_group_ids
 
}
module "compute-DB" {
  source = "../../modules/compute"
  
  instance_count         = "1"
  instance_name			 = "TF-eShopDB"
  instance_type          = var.instance_type
  ami_id                 = var.ami_id
  key_pair_name          = "eshoponweb-key"
  user_data              = file("./../../modules/compute/DB-user_data.sh") 
  public_subnet_id       = module.network.public_subnet_ids[1]
  sg_ids                 = module.security.security_group_ids
}

module "storage" {
  source = "../../modules/storage"
  
  bucket_name        = var.bucket_name
  availability_zone  = var.availability_zone

}

module "monitoring" {
  source = "../../modules/monitoring"
  
  log_retention_days = var.log_retention_days
  alert_email        = var.alert_email
  cpu_threshold      = var.cpu_threshold
  ec2_instance_id    = module.compute-WebApp.ec2_ids   

}