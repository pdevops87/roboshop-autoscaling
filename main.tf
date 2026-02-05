// create a launch template
resource "aws_launch_template" "lt" {
  name = "${var.env}-${var.component}"
  image_id =var.ami
  instance_type = "t2.micro"
   tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-${var.component}"
    }
  }
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {}))
}

resource "aws_autoscaling_group" "bar" {
  name                      = "${var.env}-${var.component}"
  max_size                  = 5
  min_size                  = 1
  availability_zones = ["us-east-1a","us-east-1b"]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
   tag {
    key                 = "${var.env}-${var.component}"
    value               = "${var.env}-${var.component}"
    propagate_at_launch = true
  }


}
