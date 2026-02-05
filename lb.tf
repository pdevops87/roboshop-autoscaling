resource "aws_lb" "test" {
  name               = "${var.env}-${var.component}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg]
  subnets            = [var.subnet_id]
   tags = {
    Name = "${var.env}-${var.component}-lb"
  }
}