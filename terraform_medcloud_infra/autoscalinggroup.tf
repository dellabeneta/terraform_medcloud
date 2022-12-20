resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "autoscalinggroup"
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 180
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = [for subnet in aws_subnet.subnet : subnet.id]

  target_group_arns = [aws_lb_target_group.target_group.arn]


  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}