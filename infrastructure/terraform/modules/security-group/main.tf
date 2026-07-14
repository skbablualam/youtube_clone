#############################################################
# Jenkins Security Group
#############################################################

resource "aws_security_group" "jenkins_sg" {

  name        = "${var.project_name}-${var.environment}-jenkins-sg"
  description = "Security Group for Jenkins Server"
  vpc_id      = var.vpc_id

  ###########################################################
  # SSH
  ###########################################################

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [var.my_ip]
  }

  ###########################################################
  # Jenkins
  ###########################################################

  ingress {
    description = "Jenkins"

    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################
  # HTTP
  ###########################################################

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################
  # HTTPS
  ###########################################################

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################
  # Outbound
  ###########################################################

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-jenkins-sg"
  }
}

#############################################################
# Minikube Security Group
#############################################################

resource "aws_security_group" "minikube_sg" {

  name        = "${var.project_name}-${var.environment}-minikube-sg"
  description = "Security Group for Kubernetes Server"

  vpc_id = var.vpc_id

  ###########################################################
  # SSH
  ###########################################################

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [var.my_ip]
  }

  ###########################################################
  # HTTP
  ###########################################################

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################
  # HTTPS
  ###########################################################

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################
  # Kubernetes NodePort
  ###########################################################

  ingress {

    description = "Kubernetes NodePort"

    from_port = 30000
    to_port   = 32767
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ###########################################################
  # Kubernetes API
  ###########################################################

  ingress {

    description = "Kubernetes API"

    from_port = 6443
    to_port   = 6443
    protocol  = "tcp"

    cidr_blocks = [var.my_ip]
  }
  ###########################################################
  # Prometheus
  ###########################################################

  ingress {

    description = "Prometheus"

    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"

    cidr_blocks = [var.my_ip]
  }
  ###########################################################
  # Outbound
  ###########################################################
  ###########################################################
  # Grafana
  ###########################################################

  ingress {

    description = "Grafana"

    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"

    cidr_blocks = [var.my_ip]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-minikube-sg"
  }
}
