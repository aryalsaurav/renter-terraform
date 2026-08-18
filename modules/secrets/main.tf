resource "aws_secretsmanager_secret" "application" {
  name = var.application_secret_name
  recovery_window_in_days = 0

  tags = {
    Name = var.application_secret_name
  }
}