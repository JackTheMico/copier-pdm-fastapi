#!/usr/bin/env bash
set -e

pipx install pdm

if [ -n "${PDM_MULTIRUN_VERSIONS}" ]; then
  if [ "${PDM_MULTIRUN_USE_VENVS}" -eq "1" ]; then
    for version in ${PDM_MULTIRUN_VERSIONS}; do
      if ! pdm venv --path "${version}" &>/dev/null; then
        pdm venv create --name "${version}" "${version}"
      fi
    done
  fi
  pdm multirun -v pdm install -G:all
else
  pdm install -G:all
fi

pdm run duty vscode
