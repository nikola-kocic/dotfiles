#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

arg1="${1:-}"

FILENAME="${HOME}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S-%3N').png"
scrot ${arg1} "${FILENAME}"
copyq write image/png - < "${FILENAME}"
copyq select 0
