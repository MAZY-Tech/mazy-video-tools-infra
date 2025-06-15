output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "issuer_uri" {
  value = local.cognito_issuer_uri
}

output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.users.id
}

output "client_id" {
  description = "ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.frontend.id
}

output "cognito_domain" {
  description = "Cognito Hosted UI domain"
  value       = aws_cognito_user_pool_domain.domain.domain
}
