resource "aws_ecr_repository" "prod_{{ cookiecutter.project_slug_simple }}_ecr" {
  name = "{{ cookiecutter.ecr_repo_name }}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_ecr"
  }
}
