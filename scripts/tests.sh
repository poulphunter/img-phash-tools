#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# shellcheck source=/dev/null
source ./.venv/bin/activate

pip install .

#imgPHash ./tests/datas/imageBlack.png --mode pHash
#imgPHash ./tests/datas/imageBlackRectangle1.png --mode pHash
#imgPHash ./tests/datas/imageBlackRectangle2.png --mode pHash
#imgPHash ./tests/datas/imageBlack.png --mode pHash --compare ./tests/datas/imageBlackRectangle1.png
#imgPHash ./tests/datas/imageBlack.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png
#imgPHash ./tests/datas/imageBlackRectangle1.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png

pytest --cov-report term-missing --cov=.venv/lib/python3.11/site-packages/imgphash tests/
#coverage run -m pytest
#coverage report -m

# Create differents python version environments and install them
for pythonVersion in "${pythonVersions[@]}"
do
  echo "test lib in python environment ${pythonVersion}"
  # shellcheck source=/dev/null
  source ".venv_${pythonVersion}/bin/activate"
  pytest --cov-report term-missing --cov=".venv_${pythonVersion}/lib/python${pythonVersion}/site-packages/imgphash" tests/
  # test presence and if the command line work well
  .venv_${pythonVersion}/bin/imgphash ./tests/datas/imageBlackRectangle1.png --mode pHash | grep "8319147471542838937"
done