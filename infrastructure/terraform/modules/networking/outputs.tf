output "vpc_id" {
  description = "VPC ID"

  value = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"

  value = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"

  value = aws_internet_gateway.this.id
}

output "route_table_id" {
  description = "Public Route Table ID"

  value = aws_route_table.public.id
}