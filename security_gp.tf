resource "aws_security_group" "sg" {
  for_each = var.db_components
  name = "${each.key}-${var.env}"
  vpc_id = "vpc-02a94ee8944923438"
  dynamic "ingress" {
    for_each = each.value["ports"]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol  = "tcp"
      description = ingress.key
    }
  }
  egress {
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "-1"
  }
  tags = {
    Name = "${var.env}-${each.key}"
  }
}