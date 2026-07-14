#!/bin/bash

################################################################################
# Script Name : install-jenkins.sh
# Description : Install Jenkins, Docker, Terraform, AWS CLI, NodeJS,
#               Trivy, kubectl and Git on Ubuntu 22.04
#
# Author      : Bablu Alam
################################################################################

set -e

echo "=========================================================="
echo "Updating Ubuntu..."
echo "=========================================================="

sudo apt update -y
sudo apt upgrade -y

################################################################################
# Install Java
################################################################################

echo "Installing Java..."

sudo apt install -y openjdk-17-jdk

java -version

################################################################################
# Install Git
################################################################################

echo "Installing Git..."

sudo apt install -y git

git --version

################################################################################
# Install Docker
################################################################################

echo "Installing Docker..."

sudo apt install -y docker.io

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker ubuntu

sudo usermod -aG docker jenkins || true

docker --version

################################################################################
# Install Jenkins
################################################################################

echo "Installing Jenkins..."

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y

sudo apt install -y jenkins

sudo systemctl enable jenkins

sudo systemctl start jenkins

################################################################################
# Install NodeJS 20
################################################################################

echo "Installing NodeJS..."

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt install -y nodejs

node -v

npm -v

################################################################################
# Install AWS CLI v2
################################################################################

echo "Installing AWS CLI..."

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

sudo apt install unzip -y

unzip awscliv2.zip

sudo ./aws/install

aws --version

################################################################################
# Install Terraform
################################################################################

echo "Installing Terraform..."

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform -y

terraform version

################################################################################
# Install kubectl
################################################################################

echo "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

kubectl version --client

################################################################################
# Install Trivy
################################################################################

echo "Installing Trivy..."

sudo apt install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb \
$(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt update

sudo apt install trivy -y

trivy --version

################################################################################
# Enable Services
################################################################################

sudo systemctl enable docker

sudo systemctl enable jenkins

sudo systemctl restart docker

sudo systemctl restart jenkins

################################################################################
# Display Versions
################################################################################

echo ""
echo "================ Installed Versions ================"

java -version

git --version

docker --version

terraform version

aws --version

node -v

npm -v

kubectl version --client

trivy --version

echo ""
echo "===================================================="
echo " Jenkins Installation Completed Successfully!"
echo "===================================================="

echo ""
echo "Jenkins URL:"
echo "http://<JENKINS_PUBLIC_IP>:8080"
echo ""

echo "Initial Admin Password:"
echo ""

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo ""

echo "===================================================="
echo "Next Step:"
echo "1. Login to Jenkins"
echo "2. Install Suggested Plugins"
echo "3. Configure Tools"
echo "4. Configure Credentials"
echo "5. Create Pipeline"
echo "===================================================="