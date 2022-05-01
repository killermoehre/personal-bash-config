#!/bin/bash

pushd "$HOME/.virtualenvs" || exit 0
declare _requirements_txt=""

for _requirements_txt in *"/requirements.txt"; do
    _venv="${_requirements_txt%%requirements.txt}"
    printf 'Creating/upgrading %s/%s' "$PWD" "$_venv"
    /usr/local/bin/python3 -m venv --upgrade --upgrade-deps "$_venv"
    pushd "$_venv" || exit 1
    export VIRTUAL_ENV="$PWD"
    ./bin/python3 -m pip install --upgrade --upgrade-strategy eager -r requirements.txt
    unset VIRTUAL_ENV
    popd || exit 1
done

popd || exit 0
