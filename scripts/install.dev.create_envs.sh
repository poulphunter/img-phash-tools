#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# Create base env
python3 -m venv .venv
# shellcheck source=/dev/null
source ./.venv/bin/activate
pip3 install uv
which uv | grep "/.venv/"
#uv cache clean
#uv cache prune
pip3 install --upgrade pip setuptools
pip3 install -r requirements.txt
pip3 install -r requirements.dev.txt
# 🧼 🧽
rm -Rf src/img_phash_tools.egg-info
python3 -c "from setuptools import setup; setup()" clean --all
pip3 install .
# 🧼 🧽
rm -Rf src/img_phash_tools.egg-info
python3 -c "from setuptools import setup; setup()" clean --all

# Install pythons versions
# shellcheck source=/dev/null
for pythonVersion in "${pythonVersions[@]}"
do
  echo "install python version ${pythonVersion}"
  uv python install "${pythonVersion}"
done

# Create differents python version environments and install them
for pythonVersion in "${pythonVersions[@]}"
do
  echo "create python environment ${pythonVersion}"
  deactivate
  # shellcheck source=/dev/null
  source ./.venv/bin/activate
  uv venv --python "${pythonVersion}" ".venv_${pythonVersion}"
  deactivate
  # shellcheck source=/dev/null
  source ".venv_${pythonVersion}/bin/activate"
  python3 -m ensurepip --upgrade
  pip3 install --upgrade pip
  pip3 install -r requirements.txt
  pip3 install -r requirements.dev.txt
  # 🧼 🧽
  rm -Rf src/img_phash_tools.egg-info
  python3 -c "from setuptools import setup; setup()" clean --all
  pip3 install .
  # 🧼 🧽
  rm -Rf src/img_phash_tools.egg-info
  python3 -c "from setuptools import setup; setup()" clean --all
done

