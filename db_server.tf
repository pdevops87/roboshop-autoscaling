resource "aws_instance" "db_servers" {
  for_each         =  var.db_components
  ami              =  var.ami
  instance_type    = each.value["instance_type"]
  security_groups  = [aws_security_group.sg[each.key].id]
  user_data        = base64encode(templatefile("${path.module}/user-data.sh", {
    component      = each.key
    env            = var.env
  }))
  tags = {
    Name = "${each.key}-${var.env}"
  }
}