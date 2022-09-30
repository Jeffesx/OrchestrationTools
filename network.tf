resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "private-subnet-1a" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Work Public Subnet"
  }
}

resource "aws_subnet" "public-subnet-1a" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Work Public Subnet"
  }
}

resource "aws_internet_gateway" "terraform-vpc-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Terraform VPC IGW"
  }
}

resource "aws_internet_gateway_attachment" "vpc-igw-attach" {
  count = 0
  internet_gateway_id = aws_internet_gateway.terraform-vpc-igw.id
  vpc_id = aws_vpc.terraform-vpc.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-vpc-igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

##################### OUTPUTS ########################

output "vpc_id" {
value = aws_vpc.terraform-vpc.id
}

output "vpc_arn" {
value = aws_vpc.terraform-vpc.arn
}

output "subnet_name_1" {
value = aws_subnet.private-subnet-1a.tags_all
description = "Nome da subnet privada"
}

output "subnet_name_1_id" {
value = aws_subnet.private-subnet-1a.id
description = "Id da subnet privada"
}

output "subnet_name_1_range" {
value = aws_subnet.private-subnet-1a.cidr_block
description = "Range da subnet privada"
}

output "subnet_name_2" {
value = aws_subnet.public-subnet-1a.tags_all
description = "Nome da subnet publica"
}

output "subnet_name_2_id" {
value = aws_subnet.public-subnet-1a.id
description = "Id da subnet publica"
}

output "subnet_name_2_range" {
value = aws_subnet.public-subnet-1a.cidr_block
description = "Range da subnet publica"
}