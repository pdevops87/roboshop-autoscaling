resource "aws_launch_template" "lt" {
  for_each = var.app_components
  name = "${each.key}-${var.env}"
  image_id =var.ami
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [aws_security_group.app_sg[each.key].id]
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    component    = each.key
    env          = var.env
  }))
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = each.key
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  depends_on = [aws_launch_template.lt,aws_lb_target_group.tg]
  for_each = var.app_components
  name     = "${var.env}-asg"
  desired_capacity = each.value["asg"]["min"]
  max_size =  each.value["asg"]["max"]
  min_size = each.value["asg"]["min"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  target_group_arns = [aws_lb_target_group.tg[each.key].arn]
  launch_template {
    name    = aws_launch_template.lt[each.key].name
    version = "$Latest"
  }
  tag {
    key                 = "${var.env}-${each.key}"
    value               = "${var.env}-${each.key}"
    propagate_at_launch = true
  }
}

