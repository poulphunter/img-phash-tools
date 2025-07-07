#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

DUPIMG=$(dupimg --help)
IMGPHASH=$(imgphash --help)
QSIMG=$(qsimg --help)
SIMG=$(simg --help)
echo "${DUPIMG}" > ./doc/dupimg.cli.txt
echo "${IMGPHASH}" > ./doc/imgphash.cli.txt
echo "${QSIMG}" > ./doc/qsimg.cli.txt
echo "${SIMG}" > ./doc/simg.cli.txt


cp ./doc/README.to_gen.md ./README.test.md
sed -e 's/[&%\\]/\\&/g' \
    -e '$!s/$/\\/' \
    -e '1s/^/s%dupimg_cli_replace%/' \
     -e '$s/$/%g/' <<< "$DUPIMG" |
# pass to second sed instance
sed -f > "./README.test2.md" - "./README.test.md"
rm "./README.test.md"
cp "./README.test2.md" "./README.test.md"
sed -e 's/[&%\\]/\\&/g' \
    -e '$!s/$/\\/' \
    -e '1s/^/s%imgphash_cli_replace%/' \
     -e '$s/$/%g/' <<< "$IMGPHASH" |
# pass to second sed instance
sed -f > "./README.test2.md" - "./README.test.md"
rm "./README.test.md"
cp "./README.test2.md" "./README.test.md"
sed -e 's/[&%\\]/\\&/g' \
    -e '$!s/$/\\/' \
    -e '1s/^/s%qsimg_cli_replace%/' \
     -e '$s/$/%g/' <<< "$QSIMG" |
# pass to second sed instance
sed -f > "./README.test2.md" - "./README.test.md"
rm "./README.test.md"
cp "./README.test2.md" "./README.test.md"
sed -e 's/[&%\\]/\\&/g' \
    -e '$!s/$/\\/' \
    -e '1s/^/s%simg_cli_replace%/' \
     -e '$s/$/%g/' <<< "$SIMG" |
# pass to second sed instance
sed -f > "./README.test2.md" - "./README.test.md"

rm "./README.test.md"
rm "./README.md"
mv "./README.test2.md" "./README.md"

echo "🎉 Done !"