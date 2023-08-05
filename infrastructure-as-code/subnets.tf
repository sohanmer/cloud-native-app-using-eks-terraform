resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = var.region1

  tags = {
    "Name"                                       = "private1"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = var.region2

  tags = {
    "Name"                                       = "private2"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = var.region1
  map_public_ip_on_launch = true

  tags = {
    "Name"                                       = "public1"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = var.region2

  tags = {
    "Name"                                       = "public2"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}