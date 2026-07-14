variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "youtube-clone"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "terraform_state_bucket" {
  description = "S3 bucket for Terraform Remote State"
  type        = string

  # CHANGE THIS TO SOMETHING GLOBALLY UNIQUE
  default = "bablu-youtube-clone-terraform-state-2026"
}

variable "terraform_lock_table" {
  description = "Terraform Lock Table"
  type        = string
  default     = "youtube-clone-terraform-lock"
}