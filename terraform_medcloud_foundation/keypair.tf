resource "aws_key_pair" "key_pair" {
  key_name   = "medcloud"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    "Name" = "${var.project}_keypair"
  }
}