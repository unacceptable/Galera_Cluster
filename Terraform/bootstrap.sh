#!/usr/bin/env bash
set -e

sudo apt-get update -y

# Updtes will be handled by Ansible
# sudo DEBIAN_FRONTEND=noninteractive \
#     apt-get upgrade -y

sudo apt-get install -y \
    python \
    python-pip
