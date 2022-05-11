#Request cert from ACM
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = var.environment_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

#DNS Validation with Route53
data "aws_route53_zone" "dns" {
  name         = var.zone_name
  private_zone = false
}

resource "aws_route53_record" "dns" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.dns.zone_id
}

resource "aws_acm_certificate_validation" "dns" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.dns : record.fqdn]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.dns.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = true
  }
}