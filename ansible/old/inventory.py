#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--list", help="Returns inventory", action="store_true")
args = parser.parse_args()

if args.list:
    with open('inventory.json') as f:
        print(f.read())
