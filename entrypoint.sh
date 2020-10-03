#!/bin/bash

set -eo pipefail

curl -sSL https://raw.githubusercontent.com/victoriadrake/hydra-link-checker/master/hydra.py > hydra.py

if grep -q "404: Not Found" hydra.py; then
    echo -e "Couldn't get link checking program. Is victoriadrake/hydra-link-checker available?"
    exit 1
fi

if [[ -z "${URL}" ]]; then
    echo -e "No URL set."
fi

if ! [[ -z "${URL}" ]] && [[ -z "${FILENAME}" ]]; then
    time python3 hydra.py ${URL} ${CONFIG:-""}
fi

if ! [[ -z "${URL}" ]] && ! [[ -z "${FILENAME}" ]]; then
    time python3 hydra.py ${URL} ${CONFIG:-""} > ${FILENAME}
fi
