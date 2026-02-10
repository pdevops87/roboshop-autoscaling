#!/bin/bash
set -e  # Exit immediately if any command fails
python3 -m pip install --upgrade pip
python3 -m pip install ansible
ansible-pull -i localhost, -U https://github.com/pdevops87/roboshop-ansible-v4 roboshop.yaml -e component=${component} -e env=${env}
