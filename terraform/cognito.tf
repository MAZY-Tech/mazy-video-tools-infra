resource "aws_cognito_user_pool" "users" {
  name = "mazy-video-tools-users"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Bem-vindo ao MAZY Video Tools – confirme seu e-mail"
    email_message        = "Olá,\n\nSeu código de verificação é: {####}\n\nObrigado por se cadastrar!"
  }

  username_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "frontend" {
  name                                 = "mazy-video-tools-frontend"
  user_pool_id                         = aws_cognito_user_pool.users.id
  generate_secret                      = true
  explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  supported_identity_providers         = ["COGNITO"]
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "profile", "email"]
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "mazy-video-tools"
  user_pool_id = aws_cognito_user_pool.users.id
}

locals {
  cognito_issuer_uri = "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.users.id}"
}
