resource "aws_security_group" "sg_loadbalancer" {
  name        = "sg_loadbalancer"
  description = "Grupo de Seguranca para o Load Balancer"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Permitir HTTP de toda as Origens"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir HTTPS de todas as Origens"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    description = "Permitir acesso total de Saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  

  tags = {
    "Name" = "${var.project}_loadbalancer_sg"
  }
}