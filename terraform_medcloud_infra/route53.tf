resource "aws_route53_record" "alias_route53_to_alb" {
  zone_id = "Z0999433ZG0Q0Z7K66A7"
  name    = "dellops.online"
  type    = "A"

  alias {
    name                   = aws_lb.loadbalancer.dns_name
    zone_id                = aws_lb.loadbalancer.zone_id
    evaluate_target_health = true
  }
}