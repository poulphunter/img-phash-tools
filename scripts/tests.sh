#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# shellcheck source=/dev/null
source ./.venv/bin/activate

pip install .
pytest --cov-report term-missing --cov=.venv/lib/python3.11/site-packages/imgphash tests/

# Create differents python version environments and install them
for pythonVersion in "${pythonVersions[@]}"
do
  echo "test lib in python environment ${pythonVersion}"
  # shellcheck source=/dev/null
  source ".venv_${pythonVersion}/bin/activate"
  pip3 install .
  pytest --cov-report term-missing --cov=".venv_${pythonVersion}/lib/python${pythonVersion}/site-packages/imgphash" tests/
  # test presence and if the command line work well
  ".venv_${pythonVersion}/bin/imgphash" ./tests/datas/imageBlackRectangle1.png --mode pHash | grep "8319147471542838937"
  ".venv_${pythonVersion}/bin/dupimg" ./tests/datas/ --mode averageHash --recurse | grep "./tests/datas/imageBlackCircle1.png;./tests/datas/imageBlackRectangle2.png;"
done

# shellcheck source=/dev/null
source ./.venv/bin/activate
./scripts/tests_coverage.sh
