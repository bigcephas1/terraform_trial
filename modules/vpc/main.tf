resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
   tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-odility"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "key_name" {
  value = aws_key_pair.example.key_name
}
