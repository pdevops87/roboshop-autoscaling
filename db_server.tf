resource "aws_instance" "db_servers" {
  for_each         =  var.db_components
  ami              =  var.ami
  instance_type    = each.value["instance_type"]
  vpc_security_group_ids = [aws_security_group.sg[each.key].id]
  user_data_base64 = base64encode(templatefile("${path.module}/user-data.sh", {
    component      = each.key
    env            = var.env
  }))
  tags = {
    Name = "${each.key}-${var.env}"
  }
}