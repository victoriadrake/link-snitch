#!/bin/bash

set -eo pipefail

curl -sSL https://raw.githubusercontent.com/victoriadrake/hydra-link-checker/master/hydra.py > hydra.py

if grep -q "404: Not Found" hydra.py; then
    echo -e "Couldn't get link checking program. Is victoriadrake/hydra-link-checker available?"
    exit 1
fi

hydracmd="hydracmd"
rm -f $hydracmd
touch $hydracmd

addcmd() {
    echo "$@" >> $hydracmd
}

addcmd "time python3 hydra.py"

if [[ -z "${URL}" ]]; then
    echo -e "No URL set."
    exit 1
fi

if ! [[ -z "${URL}" ]]; then
    addcmd $URL
fi

if ! [[ -z "$CONFIG" ]]; then
    addcmd "--config"
    addcmd $CONFIG
fi

if ! [[ -z "${FILENAME}" ]]; then
    addcmd ">"
    addcmd $FILENAME
fi

eval `cat $hydracmd`
