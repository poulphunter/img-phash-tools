#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

# shellcheck source=/dev/null
source ./.venv/bin/activate

black ./src ./tests
prospector --profile ./prospector.yaml ./src
# You don't want to see this... 😱
#prospector --profile ./prospector.yaml ./tests