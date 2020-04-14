#!/bin/sh -l

set -e

export MARKDOWN_DIR=/github/workspace

nix-build

find . -type l -exec '/copy-from-store.sh' '{}' ';'

mv /result /github/workspace
