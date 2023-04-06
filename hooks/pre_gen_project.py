import os
import sys


AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")


if not AWS_ACCESS_KEY_ID and not AWS_SECRET_ACCESS_KEY:
    print("ERROR: no AWS credentials found on host. Please set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables")

    # exits with status 1 to indicate failure
    sys.exit(1)


if not os.path.exists("{{ cookiecutter.ssh_pub_key_file }}"):
    print(f"ERROR: path '{{ cookiecutter.ssh_pub_key_file }}' does not exist")

    # exits with status 1 to indicate failure
    sys.exit(1)
