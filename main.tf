provider "aws" {
  region = "ap-northeast-2"
}

# Create VPC
resource "aws_vpc" "my-project-vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "my-project-vpc"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "my-project-igw" {
  vpc_id = aws_vpc.my-project-vpc.id

  tags = {
    Name = "my-project-igw"
  }
}

# Create public subnet 1
resource "aws_subnet" "my-project-public-subnet-1" {
  vpc_id     = aws_vpc.my-project-vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-project-public-subnet-1"
  }
}

# Create public subnet 2
resource "aws_subnet" "my-project-public-subnet-2" {
  vpc_id     = aws_vpc.my-project-vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "my-project-public-subnet-2"
  }
}

# Create public subnet route table
resource "aws_route_table" "my-project-public-rt" {
  vpc_id = aws_vpc.my-project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-project-igw.id
  }

  tags = {
    Name = "my-project-public-rt"
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "my-project-public-rt-association-1" {
  subnet_id      = aws_subnet.my-project-public-subnet-1.id
  route_table_id = aws_route_table.my-project-public-rt.id
}

resource "aws_route_table_association" "my-project-public-rt-association-2" {
  subnet_id      = aws_subnet.my-project-public-subnet-2.id
  route_table_id = aws_route_table.my-project-public-rt.id
}

# Security group for the public subnet
resource "aws_security_group" "my-project-public-sg" {
  name_prefix = "my-project-public-sg"
  vpc_id      = aws_vpc.my-project-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  tags = {
    Name = "my-project-public-sg"
  }
}