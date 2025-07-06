#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

#./scripts/install.dev.install_python.sh

./scripts/lint_scripts.sh

./scripts/install.dev.sh

./scripts/lint.sh

./scripts/tests.sh

echo "🎉 Done !"