#!/bin/bash

pushd "$HOME/.virtualenvs" || exit 0
declare _requirements_txt=""

declare -i _vpn_connected=1  # 0 - connected; 1 - not connected
if test -x /usr/sbin/scutil; then
    if [[ "$(/usr/sbin/scutil --nc status "SAP Global" | head -1)" == "Connected" ]]; then
        _vpn_connected=0
    fi
fi

export PYTHONUNBUFFERED=x
export PYTHONDONTWRITEBYTECODE=x

for _requirements_txt in *"/requirements.txt"; do
    declare -a pip_options=("-m" "pip" "--quiet" "--quiet" "install" "--upgrade" "--upgrade-strategy" "eager")
    # skip venvs requiring VPN access
    if ((_vpn_connected == 1)) && grep -q -E '(github.wdf.sap.corp|github.tools.sap)' "$_requirements_txt"; then
        continue
    fi
    {
    _venv="${_requirements_txt%%/requirements.txt}"
    printf 'Creating/upgrading %s/%s\n' "$PWD" "$_venv"
    python3 -m venv --upgrade "$_venv"
    export VIRTUAL_ENV="$PWD/$_venv"
    pushd "$_venv" || exit 1
    "$VIRTUAL_ENV/bin/python3" "${pip_options[@]}" pip wheel
    pip_options+=('-r' "$VIRTUAL_ENV/requirements.txt")
    if test -e "$VIRTUAL_ENV/optional-requirements.txt"; then
        pip_options+=('-r' "$VIRTUAL_ENV/optional-requirements.txt")
    fi
    "$VIRTUAL_ENV/bin/python3" "${pip_options[@]}"
    popd || exit 1
    unset VIRTUAL_ENV
    }
done

wait
popd || exit 0
