resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet"
  subnet_ids = aws_subnet.subnet.*.id
}