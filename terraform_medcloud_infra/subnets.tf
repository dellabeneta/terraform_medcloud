resource "aws_subnet" "subnet" {
  count                   = var.availability_zones_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.project}_subnet_${count.index}"
  }
}