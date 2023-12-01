resource "aws_cognito_user_pool" "main_cognito_user_pool" {
  name = "main-user-pool-dl"
  mfa_configuration          = "ON"
  sms_authentication_message = "Your code is {####}"

  sms_configuration {
    external_id    = "external_example"
    sns_caller_arn = aws_iam_role.iam_main_role_cognito.arn
    sns_region     = var.aws_region
  }

  software_token_mfa_configuration {
    enabled = true
  }
}

resource "aws_cognito_user" "maing_cognito_user" {
  user_pool_id = aws_cognito_user_pool.main_cognito_user_pool.id
  username     = "user-integration"
}

resource "aws_cognito_identity_provider" "main_cognito_ip" {
  user_pool_id  = aws_cognito_user_pool.main_cognito_user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = "!12%&$CAOS09"
    client_secret    = "ABCKEUDHAW21272SK"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}