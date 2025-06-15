resource "aws_acm_certificate_validation" "wildcard" {
  certificate_arn = aws_acm_certificate.wildcard.arn

  validation_record_fqdns = [
    for o in aws_acm_certificate.wildcard.domain_validation_options :
    o.resource_record_name
  ]
}
