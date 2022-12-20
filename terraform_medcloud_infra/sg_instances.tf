resource "aws_security_group" "sg_instances" {
  name        = "sg_instances"
  description = "Grupo de Seguranca para as Instancias"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Permitir PING de qualquer Origem"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir SSH a partir do Meu Micro"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.131.162.98/32"]
  }

  ingress {
    description     = "Permitir HTTP originado do Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_loadbalancer.id}"]
  }

  egress {
    description     = "Permitir acesso total de saida"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    //security_groups = ["${aws_security_group.sg_loadbalancer.id}"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.project}_instances_sg"
  }
}