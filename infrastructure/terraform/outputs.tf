output "vpc_id" {

  value = module.networking.vpc_id

}

output "public_subnet_id" {

  value = module.networking.public_subnet_id

}

output "jenkins_public_ip" {

  value = module.jenkins.public_ip

}

output "minikube_public_ip" {

  value = module.minikube.public_ip

}

output "jenkins_private_ip" {

  value = module.jenkins.private_ip

}

output "minikube_private_ip" {

  value = module.minikube.private_ip

}