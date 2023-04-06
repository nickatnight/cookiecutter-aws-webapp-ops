resource "aws_vpc" "prod_{{ cookiecutter.project_slug_simple }}_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_vpc"
  }
}

resource "aws_internet_gateway" "prod_{{ cookiecutter.project_slug_simple }}_igw" {
  vpc_id = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_igw"
  }
}

resource "aws_subnet" "prod_{{ cookiecutter.project_slug_simple }}_public_subnet" {
  count             = var.subnet_count.public
  vpc_id            = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_public_subnet_${count.index}"
  }
}

resource "aws_subnet" "prod_{{ cookiecutter.project_slug_simple }}_private_subnet" {
  count             = var.subnet_count.private
  vpc_id            = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "prod_{{ cookiecutter.project_slug_simple }}_private_subnet_${count.index}"
  }
}

resource "aws_route_table" "prod_{{ cookiecutter.project_slug_simple }}_public_rt" {
  vpc_id = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_{{ cookiecutter.project_slug_simple }}_igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = var.subnet_count.public
  route_table_id = aws_route_table.prod_{{ cookiecutter.project_slug_simple }}_public_rt.id
  subnet_id      = 	aws_subnet.prod_{{ cookiecutter.project_slug_simple }}_public_subnet[count.index].id
}

resource "aws_route_table" "prod_{{ cookiecutter.project_slug_simple }}_private_rt" {
  vpc_id = aws_vpc.prod_{{ cookiecutter.project_slug_simple }}_vpc.id
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_count.private
  route_table_id = aws_route_table.prod_{{ cookiecutter.project_slug_simple }}_private_rt.id
  subnet_id      = aws_subnet.prod_{{ cookiecutter.project_slug_simple }}_private_subnet[count.index].id
}
