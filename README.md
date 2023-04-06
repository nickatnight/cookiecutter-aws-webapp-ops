<p align="center">
    <a href="https://github.com/nickatnight/cookiecutter-aws-webapp-ops/actions">
        <img alt="GitHub Actions status" src="https://github.com/nickatnight/cookiecutter-aws-webapp-ops/actions/workflows/main.yml/badge.svg">
    </a>
    <a href="https://github.com/nickatnight/cookiecutter-aws-webapp-ops/releases"><img alt="Release Status" src="https://img.shields.io/github/v/release/nickatnight/cookiecutter-aws-webapp-ops"></a>
</p>

# cookiecutter-aws-webapp-ops
[Cookiecutter](https://github.com/cookiecutter/cookiecutter) template for scaffolding web application/api infrastructure on AWS using Terraform and Ansible

## Quickstart
Install the latest Cookiecutter if you haven't installed it yet (this requires Cookiecutter 1.4.0 or higher):
```sh
pip install cookiecutter
```

Generate project:
```sh
cookiecutter https://github.com/nickatnight/cookiecutter-aws-webapp-ops.git
```

## Input Variables
The generator (cookiecutter) will ask you for some data, you might want to have at hand before generating the project.

The input variables, with their default values (some auto generated) are:

* `project_name`: The name of the project
* `project_slug`: The development friendly name of the project. By default, based on the project name
* `project_slug_simple`: The database friendly name of the project. By default, based on the project name
* `first_name`: Name of individual running the project
* `ssh_pub_key_file`: Absolute path of the ssh pub key file for above user
* `aws_region`: AWS region where resources will be deployed
* `aws_cli_version`: AWS cli version to install on ec2 instance
* `ami_distro`: AMI distro name
* `rds_username`: Master username for RDS instance
* `rds_password`: Master username password for RDS instance
* `rds_storage`: Amount of storage in gigabytes
* `rds_engine`: RDS databse engine
* `rds_engine_version`: RDS databse engine version
* `rds_instance_class`: RDS databse engine instance class
* `rds_name`: RDS databse name
* `ec2_instance_type`: EC2 instance type
* `ecr_repo_name`: ECR repository name
* `enable_stack_monitoring`: Enable Docker Swarm monitoring stack

## More Details
After using this generator, your new project (the directory created) will contain an extensive `README.md` with instructions for development, deployment, etc. You can view it [here](/%7B%7B%20cookiecutter.project_slug%20%7D%7D/README.md)

## Acknowledgements
Big thanks to [nemd](https://github.com/nemd/) / [ironhalik](https://github.com/ironhalik/) for the inspiration and Docker hax
