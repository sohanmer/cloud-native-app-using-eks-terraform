resource "aws_subnet" "private-us-west-2a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-west-2a"

  tags = {
    "Name"                                       = "private-us-west-2a"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "private-us-west-2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-west-2b"

  tags = {
    "Name"                                       = "private-us-west-2b"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "public-us-west-2a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                       = "public-us-west-2a"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}

resource "aws_subnet" "public-us-west-2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "us-west-2b"

  tags = {
    "Name"                                       = "public-us-west-2b"
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/cloud-native-cluster" = "owned"
    "ManagedBy"                                  = "Terraform"
  }
}