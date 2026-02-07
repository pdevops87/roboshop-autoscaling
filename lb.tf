resource "aws_lb" "lb" {
  name               = "${var.env}-${var.component}-lb"
  internal           = false // public
  load_balancer_type = "application"
  security_groups    = [var.sg]

  subnets            = [var.subnet_id]
   tags = {
    Name = "${var.env}-${var.component}-lb"
  }
}
resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-${var.component}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "tg_attach" {
  depends_on = [aws_launch_template.lt]
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.component
  port             = 80
}
