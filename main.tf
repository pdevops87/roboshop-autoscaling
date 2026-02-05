// create a launch template
resource "aws_launch_template" "foo" {
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


