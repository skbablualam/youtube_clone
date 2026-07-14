variable "aws_region" {

  type    = string
  default = "us-east-1"

}

variable "project_name" {

  type    = string
  default = "youtube-clone"

}

variable "environment" {

  type    = string
  default = "dev"

}

variable "vpc_cidr" {

  type    = string
  default = "10.0.0.0/16"

}

variable "public_subnet_cidr" {

  type    = string
  default = "10.0.1.0/24"

}

variable "availability_zone" {

  type    = string
  default = "us-east-1a"

}

variable "instance_type" {

  type    = string
  default = "t2.micro"

}

variable "key_name" {

  type = string

}

variable "my_ip" {

  description = "Your Public IP in CIDR"

  type = string

}