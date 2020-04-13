#!/bin/sh -l

set -e

nix-build

find . -type l -exec './copy-from-store.sh' '{}' ';'

git clone https://github.com/${TARGET_GITHUB_REPO} ./out && cd ./out
cp -r ./result/* ./out
git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/${TARGET_GITHUB_REPO}
git checkout "${TARGET_GITHUB_REF}"
git add -A
git commit -m "Generate weblog action"
git push
