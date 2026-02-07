// create a launch template
resource "aws_launch_template" "lt" {
  name = var.component
  image_id =var.ami
  instance_type = "t2.micro"
   tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.component
    }
  }
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {}))
}

resource "aws_autoscaling_group" "bar" {
  depends_on = [aws_launch_template.lt,aws_lb.lb]
  name                      = "${var.env}-${var.component}"
  max_size                  = 5
  min_size                  = 2
  availability_zones = ["us-east-1a","us-east-1b"]
  load_balancers = [aws_lb.lb.id]
  target_group_arns = [aws_lb_target_group.tg.arn]
  launch_template {
    name = aws_launch_template.lt.name
    version = "$Latest"
  }
   tag {
    key                 = "${var.env}-${var.component}"
    value               = "${var.env}-${var.component}"
    propagate_at_launch = true
  }
}


