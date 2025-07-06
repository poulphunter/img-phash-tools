#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# Install python softwares
echo "install/update python3"
sudo apt update
sudo apt install -y python3 python3-venv python3-pip shellcheck

