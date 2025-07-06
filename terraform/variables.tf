variable "project" {
  type    = string
  default = "mazy-video-tools"
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "upload_bucket_name" {
  description = "Name of the S3 bucket for uploads"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "allowed_ingress_cidr" {
  description = "CIDR allowed to access ALB"
  type        = string
}

variable "api_url" {
  description = "URL for API exposed to frontend"
  type        = string
}

variable "mongodb_uri" {
  description = "URI for MongoDB connection"
  type        = string
  sensitive   = true
}

variable "callback_urls" {
  description = "List of allowed callback URLs for Cognito Hosted UI"
  type        = list(string)
}

variable "logout_urls" {
  description = "List of allowed logout URLs for Cognito Hosted UI"
  type        = list(string)
}

variable "nextauth_url" {
  description = "Base URL do NextAuth (Next.js)"
  type        = string
}

variable "nextauth_secret" {
  description = "Secret do NextAuth (JWT)"
  type        = string
  sensitive   = true
}

variable "certificate_primary" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "certificate_sans" {
  description = "Subject Alternative Names (additional subdomains)"
  type        = list(string)
}

variable "api_sentry_dns" {
  type        = string
  description = "Sentry DSN for API service"
  sensitive   = true
}

variable "frontend_sentry_dns" {
  type        = string
  description = "Sentry DSN for frontend service"
  sensitive   = true
}

variable "frontend_sentry_auth_token" {
  type        = string
  description = "Sentry auth token for frontend service"
  sensitive   = true
}