#!/usr/bin/env bash
set -e

if ! command -v pdm &>/dev/null; then
  if ! command -v pipx &>/dev/null; then
    python3 -m pip install --user pipx
  fi
  pipx install pdm
fi
