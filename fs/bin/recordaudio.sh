#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

PULSE_OUTPUT_DEVICE=$(pactl list short sources | grep analog-stereo.monitor | awk '{print $2}')
FILENAME="${HOME}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S-%3N').flac"

ffmpeg -f pulse -i "${PULSE_OUTPUT_DEVICE}" -f flac -compression_level 12 "${FILENAME}"

