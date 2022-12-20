resource "aws_launch_template" "launch_template" {
  name                   = "launch-template"
  image_id               = "ami-09d3b3274b6c5d4aa"
  instance_type          = "t2.micro"
  key_name               = "medcloud"
  vpc_security_group_ids = [aws_security_group.sg_instances.id]
  user_data              = filebase64("userdata.sh")
}

