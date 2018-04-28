#!/usr/bin/python
"""
Provides an inventory of stage environment of terraform.
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


if args.list:
    os.chdir('../terraform/stage')
    app_external_ip = get_terraform_output('app_external_ip')
    db_external_ip = get_terraform_output('db_external_ip')
    db_internal_ip = get_terraform_output('db_internal_ip')

    print(json.dumps({
        'app': {
            'hosts': [app_external_ip],
            'vars': {'db_internal_ip': db_internal_ip}
        },
        'db': [db_external_ip],
    }))
