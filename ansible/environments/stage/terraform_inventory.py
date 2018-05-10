#!/usr/bin/python
"""
Provides an inventory of terraform
"""
import argparse
import json
import os
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument("--list", help="Returns inventory", action="store_true")
args = parser.parse_args()


def get_terraform_output(name):
    r = subprocess.check_output(['terraform', 'output', name])
    return r.strip()


# Determine different paths
env_path = os.path.dirname(os.path.abspath(__file__))
env = os.path.basename(env_path)

terraform_path = os.path.join(
    os.path.dirname(os.path.dirname(os.path.dirname(env_path))), 'terraform')
env_terraform_path = os.path.join(terraform_path, env)

if args.list:
    os.chdir(env_terraform_path)
    app_external_ip = get_terraform_output('app_external_ip')
    db_external_ip = get_terraform_output('db_external_ip')
    db_internal_ip = get_terraform_output('db_internal_ip')

    print(json.dumps({
        'app': {
            'hosts': [app_external_ip],
            'vars': {'db_host': db_internal_ip}
        },
        'db': [db_external_ip],
    }))
