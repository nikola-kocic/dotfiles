#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

DISCONNECTED=$(xrandr | grep -w disconnected | awk '{print $1}')
CONNECTED=$(xrandr | fgrep -w connected | awk '{print $1}')
CONNECTED_ARR=($CONNECTED)

args=()

args+=(--output "${CONNECTED_ARR[0]}" --mode 1920x1080 --pos 0x0 --rotate normal)
args+=(--output "${CONNECTED_ARR[1]}" --mode 1920x1080 --pos 1920x0 --rotate normal)

for output in ${DISCONNECTED}; do
    args+=(--output "${output}" --off)
done

#echo "executing: xrandr "${args[@]}""
xrandr "${args[@]}"

xrandr --output "${CONNECTED_ARR[0]}" --set "Broadcast RGB" "Full"
