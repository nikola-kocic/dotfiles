#!/bin/bash

CMD="pamixer --default-source"
VOLUME=$(${CMD} --get-volume)
VALUE=5

case "$1" in
  "up")
    [[ "$VOLUME" -eq 100 ]] && VALUE=0
    ${CMD} --increase $VALUE
    ;;
  "down")
    ${CMD} --decrease $VALUE
    ;;
  "mute")
    ${CMD} --toggle-mute
    ;;
esac

# notification
VOLUME=$(${CMD} --get-volume)
MUTE=$(${CMD} --get-mute)

if [ "$MUTE" == "false" ]; then
  volnoti-show $VOLUME
else
  volnoti-show -m $VOLUME
fi

