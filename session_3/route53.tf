# data "aws_route53_zone" "zone" {
#   name         = var.domain
# #   private_zone = true
# }


# resource "aws_route53_record" "jenkins" {
#   zone_id = data.aws_route53_zone.zone.id
#   name    = "${var.record}.${var.domain}"
#   type    = "A"
#   ttl     = "300"
#   records =  [aws_instance.web.public_ip]

#  depends_on = [
#   aws_instance.web
#  ]
# }