# 🏗️ Terraform Infrastructure Documentation

## Project

**YouTube Clone - Infrastructure as Code (IaC) using Terraform**

---

# Overview

This project provisions the complete AWS infrastructure using **Terraform**. The infrastructure is deployed in the **AWS us-east-1 Region** using reusable Terraform modules and a remote backend for state management.

The infrastructure includes:

- VPC
- Public Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Jenkins EC2
- Minikube EC2
- Elastic IPs (Optional)
- S3 Backend
- DynamoDB State Locking

---

# Why Terraform?

Terraform enables Infrastructure as Code (IaC), allowing infrastructure to be:

- Version Controlled
- Repeatable
- Automated
- Consistent
- Scalable

Benefits:

- Easy to recreate infrastructure
- Infrastructure versioning
- Team collaboration
- Disaster recovery
- Automated provisioning

---

# AWS Region

```
Region : us-east-1
```

---

# Infrastructure Architecture

```text
                     AWS Cloud
                  (us-east-1 Region)

                         Internet
                             │
                     Internet Gateway
                             │
                  -----------------------
                  │                     │
            Public Subnet A      Public Subnet B
                  │                     │
        -----------------       -----------------
        │               │       │               │
 Jenkins EC2        Minikube EC2             (Future)
        │               │
        │ SSH           │
        └──────► Kubernetes Cluster
```

---

# Project Structure

```
infrastructure/

├── bootstrap/
│   ├── provider.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
└── terraform/
    ├── backend.tf
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── outputs.tf
    ├── main.tf
    │
    └── modules/
        ├── networking/
        ├── security-group/
        ├── jenkins-ec2/
        └── minikube-ec2/
```

---

# Bootstrap Folder

The bootstrap configuration is executed **only once**.

Purpose:

- Create S3 Bucket
- Create DynamoDB Table
- Prepare Terraform Remote Backend

Command:

```bash
cd infrastructure/bootstrap

terraform init

terraform apply
```

Resources Created:

- S3 Bucket
- DynamoDB Lock Table

---

# Terraform Folder

The main Terraform configuration provisions:

- Networking
- Security Groups
- Jenkins Server
- Minikube Server

Command:

```bash
cd infrastructure/terraform

terraform init

terraform plan

terraform apply
```

---

# Remote Backend

Terraform state is stored remotely.

Backend:

```
S3
```

State Locking:

```
DynamoDB
```

Advantages:

- Prevents state corruption
- Supports team collaboration
- Centralized state management

---

# Modules

## Networking Module

Creates:

- VPC
- Public Subnets
- Internet Gateway
- Route Tables
- Route Associations

---

## Security Group Module

Creates Security Groups for:

### Jenkins EC2

Ports:

| Port | Purpose |
|------|----------|
| 22 | SSH |
| 8080 | Jenkins |
| 80 | HTTP |
| 443 | HTTPS |

---

### Minikube EC2

Ports:

| Port | Purpose |
|------|----------|
| 22 | SSH |
| 30000-32767 | NodePort Services |
| 6443 | Kubernetes API |
| 9090 | Prometheus |
| 3000 | Grafana |

---

## Jenkins EC2 Module

Creates:

- Ubuntu EC2
- Public IP
- Key Pair Association
- Security Group
- User Data (Optional)

Responsibilities:

- Jenkins
- Docker
- Terraform
- AWS CLI
- Trivy
- Node.js
- kubectl

---

## Minikube EC2 Module

Creates:

- Ubuntu EC2
- Public IP
- Security Group

Responsibilities:

- Docker
- Minikube
- Kubernetes
- Prometheus
- Grafana
- CloudWatch Agent

---

# Terraform Workflow

```text
Terraform Init

↓

Download Providers

↓

Terraform Validate

↓

Terraform Plan

↓

Terraform Apply

↓

AWS Infrastructure Created
```

---

# Terraform Lifecycle

Developer

↓

terraform init

↓

terraform validate

↓

terraform fmt

↓

terraform plan

↓

terraform apply

↓

AWS Infrastructure

---

# Terraform Commands

Initialize

```bash
terraform init
```

Validate

```bash
terraform validate
```

Format

```bash
terraform fmt
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

Show Outputs

```bash
terraform output
```

---

# Variables

Variables are stored in:

```
terraform.tfvars
```

Example:

```hcl
aws_region = "us-east-1"

instance_type = "t2.micro"

key_name = "youtube-key"

environment = "dev"
```

---

# Outputs

Terraform outputs:

- Jenkins Public IP
- Minikube Public IP
- VPC ID
- Subnet IDs
- Security Group IDs

Command:

```bash
terraform output
```

---

# State Management

State File:

```
terraform.tfstate
```

Remote Backend:

```
Amazon S3
```

Locking:

```
Amazon DynamoDB
```

---

# Best Practices

- Never edit the Terraform state manually.
- Store the state remotely.
- Use modules for reusable infrastructure.
- Keep variables in `terraform.tfvars`.
- Run `terraform fmt` before committing.
- Validate before applying.
- Review the execution plan.
- Protect sensitive variables.

---

# Common Issues

## State Lock Error

Solution:

Check the DynamoDB lock table.

---

## Access Denied

Verify:

- IAM User permissions
- AWS credentials
- AWS Region

---

## Provider Version Conflict

Run:

```bash
terraform init -upgrade
```

---

## Existing Resource Conflict

Import the resource:

```bash
terraform import
```

or delete the existing resource before applying.

---

# Future Enhancements

- Private Subnets
- NAT Gateway
- Auto Scaling Group
- Application Load Balancer (ALB)
- Route 53
- ACM SSL Certificates
- AWS WAF
- Amazon ECR
- Amazon EKS
- Multi-Environment (Dev/QA/Prod)

---

# Directory Structure

```
infrastructure/

├── bootstrap/
│   ├── main.tf
│   ├── provider.tf
│   ├── versions.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── terraform/
    ├── backend.tf
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── outputs.tf
    ├── main.tf
    └── modules/
        ├── networking/
        ├── security-group/
        ├── jenkins-ec2/
        └── minikube-ec2/
```

---

# Related Documentation

- [Architecture](Architecture.md)
- [CI/CD](CI-CD.md)
- [Kubernetes](Kubernetes.md)
- [Monitoring](Monitoring.md)

---

# Author

**Bablu Alam**

AWS • Terraform • Jenkins • Docker • Kubernetes • Prometheus • Grafana • CloudWatch • DevOps