resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name      = "nat"
    ManagedBy = "Terraform"
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-west-2a.id

  tags = {
    Name = "nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}