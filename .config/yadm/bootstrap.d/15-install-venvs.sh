#!/bin/bash

pushd "$HOME/.virtualenvs" || exit 0
declare _requirements_txt=""

for _requirements_txt in *"/requirements.txt"; do
    _venv="${_requirements_txt%%requirements.txt}"
    printf 'Creating/upgrading %s/%s' "$PWD" "$_venv"
    python3 -m venv --upgrade --upgrade-deps "$_venv"
    export VIRTUAL_ENV="$PWD/$_venv"
    "$VIRTUAL_ENV/bin/python3" -m pip install --upgrade --upgrade-strategy eager -r requirements.txt
    unset VIRTUAL_ENV
done

popd || exit 0
