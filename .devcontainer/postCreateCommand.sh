#!/usr/bin/env bash
export PDM_MULTIRUN_VERSIONS ?= 3.8 3.9 3.10 3.11 3.12
export PDM_MULTIRUN_USE_VENVS ?= $(if $(shell pdm config python.use_venv | grep True),1,0)

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
