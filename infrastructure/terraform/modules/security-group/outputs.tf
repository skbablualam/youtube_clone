output "jenkins_security_group_id" {

  description = "Jenkins Security Group"

  value = aws_security_group.jenkins_sg.id
}

output "minikube_security_group_id" {

  description = "Minikube Security Group"

  value = aws_security_group.minikube_sg.id
}