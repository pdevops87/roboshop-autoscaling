resource "aws_instance" "db_servers" {
  depends_on       = [aws_security_group.sg]
  for_each         =  var.db_components
  ami              =  var.ami
  instance_type    = each.value["instance_type"]
  vpc_security_group_ids = [aws_security_group.sg[each.key].id]
  user_data = templatefile("${path.module}/user-data.sh", {
    component      = each.key
    env            = var.env
  })
  tags = {
    Name = "${each.key}-${var.env}"
  }
}


resource "aws_route53_record" "db_records" {
  for_each = var.db_components
  name    = "${each.key}-${var.env}"
  type    = "A"
  zone_id = var.zone_id
  ttl = 30
  records = [aws_instance.db_servers[each.key].private_ip]
}