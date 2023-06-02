resource "aws_ssm_parameter" "rds_password" {
  name  = "/${var.environment}/rds/password"
  type  = "SecureString"
  value = random_password.rds_main_password.result
}


