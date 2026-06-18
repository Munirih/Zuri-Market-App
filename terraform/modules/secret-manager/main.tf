#------------ SECRETS MANAGER ------------ 
resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.description
}
