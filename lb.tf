# resource "aws_lb" "lb" {
#   for_each           = var.app_components
#   name               = "${each.key}-${var.env}-lb"
#   internal           = false // public
#   load_balancer_type = "application"
#   security_groups = [aws_security_group.app_sg[each.key].id]
#
#   subnets            = ["subnet-04ce96f612c9d802d","subnet-0e4eadfc446b55f58"]
#    tags = {
#     Name = "${var.env}-${var.component}-lb"
#   }
# }
# resource "aws_lb_target_group" "tg" {
#
#   name     = "${var.env}-${var.component}-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
#   target_type = "instance"
# }
