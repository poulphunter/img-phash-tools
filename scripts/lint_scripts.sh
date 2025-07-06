#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

source ./scripts/python_versions.sh

find ./scripts -type f -name "*.sh" | while read -r f; do
	if ! shellcheck -x "$f"; then
		break
	fi
done