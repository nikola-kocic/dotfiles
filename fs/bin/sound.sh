#!/bin/bash

SINK="alsa_output.pci-0000_00_1b.0.analog-stereo"
BASE_CMD="pamixer --sink ${SINK}"
VALUE=5

case "$1" in
  "up")
    ${BASE_CMD} --increase ${VALUE}
    ;;
  "down")
    ${BASE_CMD} --decrease ${VALUE}
    ;;
  "mute")
    ${BASE_CMD} --toggle-mute
    ;;
esac

# notification
VOLUME=$(${BASE_CMD} --get-volume-human)

if [ "${VOLUME}" == "muted" ]; then
  volnoti-show --mute
else
  volnoti-show ${VOLUME}
fi

killall -s USR1 py3status
