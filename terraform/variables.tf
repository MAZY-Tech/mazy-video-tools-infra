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

variable "backend_url" {
  description = "URL for backend API exposed to frontend"
  type        = string
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
}

variable "certificate_primary" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "certificate_sans" {
  description = "Subject Alternative Names (additional subdomains)"
  type        = list(string)
}
