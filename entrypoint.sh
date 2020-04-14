#!/bin/sh -l

set -e

export MARKDOWN_DIR=/github/workspace

nix-build /default.nix

find . -type l -exec '/copy-from-store.sh' '{}' ';'
