resource "aws_secretsmanager_secret" "application" {
  name = var.application_secret_name

  tags = {
    Name = var.application_secret_name
  }
}