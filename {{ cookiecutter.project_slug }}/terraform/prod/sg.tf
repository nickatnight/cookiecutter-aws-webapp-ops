resource "aws_security_group" "prod_{{ cookiecutter.project_slug_simple }}_web_sg" {
  name        = "prod_{{ cookiecutter.project_slug_simple }}_web_sg"
  description = "Security group for tutorial web servers"
  vpc_id      = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  {%- if "{{ cookiecutter.enable_stack_monitoring }}" == "y": %}
  ingress {
    description = "Allow traffic through to prometheus node exporter"
    from_port   = "9110"
    to_port     = "9110"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic through to cAdvisor"
    from_port   = "9120"
    to_port     = "9120"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  {%- endif %}
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_web_sg"
  }
}

resource "aws_security_group" "prod_{{ cookiecutter.project_slug_simple }}_db_sg" {
  name        = "prod_{{ cookiecutter.project_slug_simple }}_db_sg"
  description = "Security group for databases"
  vpc_id      = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id

  ingress {
    description     = "Allow database traffic from only the web sg"
    from_port       = "{%- if cookiecutter.rds_engine == 'postgres' %}5432{% else %}3306{%- endif %}"
    to_port         = "{%- if cookiecutter.rds_engine == 'postgres' %}5432{% else %}3306{%- endif %}"
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_{{ cookiecutter.project_slug_simple }}_web_sg.id]
  }

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_db_sg"
  }
}

resource "aws_db_subnet_group" "prod_{{ cookiecutter.project_slug_simple }}_db_subnet_group" {
  name        = "prod_{{ cookiecutter.project_slug_simple }}_db_subnet_group"
  description = "DB subnet group"
  subnet_ids  = [for subnet in aws_subnet.prod_{{ cookiecutter.project_slug_simple }}_private_subnet : subnet.id]
}
