#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

MAGNET_LINK="${1:-}"

TFILE="/tmp/magnet2torrent.$$.torrent"
LOGFILE="/tmp/magnet2torrent.$$.log"
echo "${MAGNET_LINK}" >> "${LOGFILE}"
unbuffer magnet2torrent --rewrite-file -o "${TFILE}" --open-file -m "${MAGNET_LINK}" 2>&1 >> "${LOGFILE}"
