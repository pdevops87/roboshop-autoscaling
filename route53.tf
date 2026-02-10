resource "aws_route53_record" "app_records" {
  depends_on = [aws_lb.lb]
  for_each = var.app_components
  name    = "${each.key}-${var.env}"
  type    = "CNAME"
  zone_id = var.zone_id
  records = [aws_lb.lb[each.key].dns_name]
  ttl = 30
}