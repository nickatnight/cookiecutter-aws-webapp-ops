resource "aws_db_instance" "prod_{{ cookiecutter.project_slug_simple }}_database" {
  allocated_storage      = var.settings.database.allocated_storage
  engine                 = var.settings.database.engine
  engine_version         = var.settings.database.engine_version
  instance_class         = var.settings.database.instance_class
  db_name                = var.settings.database.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.prod_{{ cookiecutter.project_slug_simple }}_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.prod_{{ cookiecutter.project_slug_simple }}_db_sg.id]
  skip_final_snapshot    = var.settings.database.skip_final_snapshot
}
