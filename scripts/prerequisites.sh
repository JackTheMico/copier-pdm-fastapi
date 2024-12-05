#!/usr/bin/env bash
set -e

echo "Prequisites: Install PDM and Pyenv"

if ! command -v pdm &>/dev/null; then
  if ! command -v pipx &>/dev/null; then
    python3 -m pip install --user pipx
  fi
  pipx install pdm pyenv
fi

echo "Prequisites: Pyenv Install Python Versions"

if [ -n "${PDM_MULTIRUN_VERSIONS}" ]; then
  if [ "${PDM_MULTIRUN_USE_VENVS}" -eq "1" ]; then
    for version in ${PDM_MULTIRUN_VERSIONS}; do
      pyenv install "${version}"
    done
  fi
  pdm multirun -v pdm install -G:all
fi
