#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

#./scripts/install.dev.install_python.sh

./scripts/install.dev.clear.sh

./scripts/install.dev.create_envs.sh

python3 -c "import cv2;import numpy as np;newImage = np.zeros((768, 768, 3), np.uint8);cv2.img_hash.pHash(newImage)"