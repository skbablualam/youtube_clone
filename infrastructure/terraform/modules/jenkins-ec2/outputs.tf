output "instance_id" {

  description = "Jenkins Instance ID"

  value = aws_instance.jenkins.id
}

output "public_ip" {

  description = "Jenkins Public IP"

  value = aws_instance.jenkins.public_ip
}

output "private_ip" {

  description = "Jenkins Private IP"

  value = aws_instance.jenkins.private_ip
}