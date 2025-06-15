resource "aws_acm_certificate" "wildcard" {
  domain_name               = var.certificate_primary
  subject_alternative_names = var.certificate_sans
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "dns_validation_records" {
  value = [
    for dvo in aws_acm_certificate.wildcard.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}
