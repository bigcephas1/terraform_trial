resource "aws_subnet" "sub1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
   tags = {
    Name = "${var.prefix}-subnets"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "RT" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

output "subnet_id" {
  value = aws_subnet.sub1.id
}
