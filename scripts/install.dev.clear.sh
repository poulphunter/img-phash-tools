#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# Remove envs
echo "remove main python environment"
rm -Rf ./.venv
rm -Rf ./build
for pythonVersion in "${pythonVersions[@]}"
do
  echo "remove python environment ${pythonVersion}"
  rm -Rf "./.venv_${pythonVersion}"
done
