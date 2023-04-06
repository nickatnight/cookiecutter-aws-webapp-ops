import os
import shutil


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)


def remove_file(filepath: str) -> None:
    os.remove(os.path.join(PROJECT_DIRECTORY, filepath))


def remove_folder(folderpath: str) -> None:
    shutil.rmtree(os.path.join(PROJECT_DIRECTORY, folderpath))


def rename_file(old: str, new: str) -> None:
    in_file = os.path.join(PROJECT_DIRECTORY, old)
    out_file = os.path.join(PROJECT_DIRECTORY, new)
    os.rename(in_file, out_file)


if "{{ cookiecutter.enable_stack_monitoring }}" == "n":
    print("Removing stack monitoring files...")

    remove_file("docker-compose.monitoring.yml")
    remove_folder("ansible/roles/exporters/")

print("Renaming files...")
rename_file("terraform/prod/secrets", "terraform/prod/secrets.tfvars")
