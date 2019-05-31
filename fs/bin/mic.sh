#!/bin/bash

BASE_CMD="pamixer --source alsa_input.pci-0000_00_1b.0.analog-stereo"
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
VOLNOTI_ARGS="
	-4 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-high.png
	-3 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-medium.png
	-2 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-low.png
	-1 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-low.png
	-0 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-muted.png"

if [ "${VOLUME}" == "muted" ]; then
  volnoti-show ${VOLNOTI_ARGS} --noprogress --mute
else
  volnoti-show ${VOLNOTI_ARGS} ${VOLUME}
fi

killall -s USR1 py3status
