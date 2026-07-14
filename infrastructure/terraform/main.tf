#############################################
# Networking
#############################################

module "networking" {

  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_cidr = var.public_subnet_cidr

  availability_zone = var.availability_zone

}

#############################################
# Security Groups
#############################################

module "security_group" {

  source = "./modules/security-group"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  my_ip = var.my_ip

}

#############################################
# Jenkins EC2
#############################################

module "jenkins" {

  source = "./modules/jenkins-ec2"

  project_name = var.project_name

  environment = var.environment

  subnet_id = module.networking.public_subnet_id

  security_group_id = module.security_group.jenkins_security_group_id

  instance_type = var.instance_type

  key_name = var.key_name

}

#############################################
# Minikube EC2
#############################################

module "minikube" {

  source = "./modules/minikube-ec2"

  project_name = var.project_name

  environment = var.environment

  subnet_id = module.networking.public_subnet_id

  security_group_id = module.security_group.minikube_security_group_id

  instance_type = var.instance_type

  key_name = var.key_name

}