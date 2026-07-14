output "instance_id" {

  description = "Minikube EC2 Instance ID"

  value = aws_instance.minikube.id
}

output "public_ip" {

  description = "Minikube Public IP"

  value = aws_instance.minikube.public_ip
}

output "private_ip" {

  description = "Minikube Private IP"

  value = aws_instance.minikube.private_ip
}