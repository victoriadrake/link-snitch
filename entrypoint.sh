#!/bin/bash

set -uo pipefail

curl -sSL https://raw.githubusercontent.com/victoriadrake/hydra-link-checker/master/hydra.py > hydra.py

if grep -q "404: Not Found" hydra.py; then
    echo "Couldn't get link checking program. Is victoriadrake/hydra-link-checker available?"
    exit 1
fi

if [[ -z "${URL:-}" ]]; then
    echo "No URL set."
    exit 1
fi

cmd=(python3 hydra.py "$URL")
if [[ -n "${CONFIG:-}" ]]; then
    cmd+=(--config "$CONFIG")
fi

echo "Running: ${cmd[*]}"

# Always show the report in the logs. When FILENAME is set, also save it there
# (using tee) so a broken-links failure isn't hidden in a file the user can't
# see from the Action output.
if [[ -n "${FILENAME:-}" ]]; then
    "${cmd[@]}" | tee "$FILENAME"
    status=${PIPESTATUS[0]}
else
    "${cmd[@]}"
    status=$?
fi

if [[ $status -ne 0 ]]; then
    echo "Link check found broken links (exit code $status). See the report above."
fi

exit $status
