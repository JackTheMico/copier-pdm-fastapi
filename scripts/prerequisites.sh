#!/usr/bin/env bash
set -e

echo "Prequisites: Install PDM and Pyenv"

if ! command -v pdm &>/dev/null; then
  if ! command -v pipx &>/dev/null; then
    python3 -m pip install --user pipx
  fi
  pipx install pdm
  pipx inject pdm pdm-multirun
  echo "Prequisites: Start To Install PyENV"
  curl https://pyenv.run | bash
fi

echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
echo 'eval "$(pyenv init -)"' >>~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc

echo "Prequisites: Pyenv Install Python Versions"

if [ -n "${PDM_MULTIRUN_VERSIONS}" ]; then
  echo "PDM Multirun Versions: ${PDM_MULTIRUN_VERSIONS}"
  IFS=';' read -ra VERSIONS <<<"${PDM_MULTIRUN_VERSIONS}"
  echo "VERSIONS: ${VERSIONS[@]}"
  if [ "${PDM_MULTIRUN_USE_VENVS}" -eq "1" ]; then
    for version in ${VERSIONS[@]}; do
      echo "Prequisites: PyENV Installing: ${version}"
      /home/vscode/.pyenv/bin/pyenv install "${version}"
    done
  fi
  pdm multirun -v pdm install -G:all
fi
