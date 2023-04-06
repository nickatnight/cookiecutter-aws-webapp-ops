resource "aws_instance" "prod_{{ cookiecutter.project_slug_simple }}_web" {
  count                  = var.settings.web_app.count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.settings.web_app.instance_type
  subnet_id              = aws_subnet.prod_{{ cookiecutter.project_slug_simple }}_public_subnet[count.index].id
  key_name               = aws_key_pair.prod_{{ cookiecutter.project_slug_simple }}_kp.key_name
  vpc_security_group_ids = [aws_security_group.prod_{{ cookiecutter.project_slug_simple }}_web_sg.id]
  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_web_${count.index}"
  }
}

resource "aws_eip" "prod_{{ cookiecutter.project_slug_simple }}_web_eip" {
  count    = var.settings.web_app.count
  instance = aws_instance.prod_{{ cookiecutter.project_slug_simple }}_web[count.index].id
  vpc      = true
  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_web_eip_${count.index}"
  }
}

resource "null_resource" "provisioner" {
  provisioner "local-exec" {
    environment = {
      ANSIBLE_SSH_RETRIES       = "30"
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }

    command = "ansible-playbook ../../ansible/provision.yml --extra-vars 'env_name=${var.env} host_ip=${aws_eip.prod_{{ cookiecutter.project_slug_simple }}_web_eip[0].public_ip} key_file=${var.env}_kp' -u ubuntu -i ${aws_eip.prod_{{ cookiecutter.project_slug_simple }}_web_eip[0].public_dns},"
  }
}
