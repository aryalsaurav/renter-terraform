output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.public :
    key => subnet.id
  }
}

output "private_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.private :
    key => subnet.id
  }
}

output "public_subnet_azs" {
  value = {
    for key, subnet in aws_subnet.public :
    key => subnet.availability_zone
  }
}

output "private_subnet_azs" {
  value = {
    for key, subnet in aws_subnet.private :
    key => subnet.availability_zone
  }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.public_a.id
}