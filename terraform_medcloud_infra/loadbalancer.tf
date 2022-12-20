resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb" "loadbalancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_loadbalancer.id]
  subnets            = [for subnet in aws_subnet.subnet : subnet.id]
}

resource "aws_lb_listener" "lb_listener_80" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "lb_listener_443" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:533084366484:certificate/684d7dcb-62e8-42e2-b95f-1a5dae672a83"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}