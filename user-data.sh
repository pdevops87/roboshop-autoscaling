#!/bin/bash
set -e  # Exit immediately if any command fails
dnf install python3.11-pip -y
pip3.11 install ansible
ansible-pull -i localhost, -U https://github.com/pdevops87/roboshop-ansible-v4 roboshop.yaml -e component=${component} -e env=${env}