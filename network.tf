resource "aws_vpc" "Project_1_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Project_1_VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.Project_1_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnets"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.Project_1_vpc.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  tags = {
    Name = "Private Subnets"
  }
}

resource "aws_subnet" "private_rds_subnets" {
  count             = 2
  vpc_id            = aws_vpc.Project_1_vpc.id
  cidr_block        = "10.0.${count.index + 20}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  tags = {
    Name = "Private RDS Subnets"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Project_1_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Project_1_vpc.id

  tags = {
    Name = "Public Subnets Route Table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[1].id
}

resource "aws_eip" "nat_eip" {}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.Project_1_vpc.id

  tags = {
    Name = "Private Subnets Route Table"
  }
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
