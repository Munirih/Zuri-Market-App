#------------ SECRETS MANAGER ------------ 
resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.description
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id

  secret_string = jsonencode({
    API_SECRET_KEY = var.api_secret_key
    STORE_NAME     = var.store_name
  })
}
