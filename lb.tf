resource "aws_lb" "lb" {
  for_each           = var.app_components
  name               = "${each.key}-${var.env}-lb"
  internal           = false // public
  load_balancer_type = "application"
  security_groups = [aws_security_group.app_sg[each.key].id]
  subnets            = ["subnet-04ce96f612c9d802d","subnet-0e4eadfc446b55f58"]
   tags = {
    Name = "${var.env}-${each.key}-lb"
  }
}
resource "aws_lb_target_group" "tg" {
  for_each           = var.app_components
  name     = "${var.env}-${each.key}-tg"
  port     = each.value["ports"]["app"]
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    path = "/health"
  }
}

resource "aws_lb_listener" "listener_ports" {
  for_each = var.app_components
  load_balancer_arn = aws_lb.lb[each.key].arn
  port              = each.value["ports"]["app"]
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[each.key].arn
  }
}
