#!/usr/bin/env bash

BASE_CMD="pamixer --source echoCancel_source"
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
#VOLNOTI_ARGS="
#	-4 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-high.png
#	-3 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-medium.png
#	-2 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-low.png
#	-1 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-low.png
#	-0 /usr/share/icons/HighContrast/256x256/status/microphone-sensitivity-muted.png"
#
#if [ "${VOLUME}" == "muted" ]; then
#  volnoti-show ${VOLNOTI_ARGS} --noprogress --mute
#else
#  volnoti-show ${VOLNOTI_ARGS} ${VOLUME}
#fi

TIMEOUT_MS=1000
ICON_BASE_PATH="/usr/share/icons/HighContrast/22x22/status"
ICON_HIGH="${ICON_BASE_PATH}/microphone-sensitivity-high.png"
ICON_MEDIUM="${ICON_BASE_PATH}/microphone-sensitivity-medium.png"
ICON_LOW="${ICON_BASE_PATH}/microphone-sensitivity-low.png"
ICON_MUTED="${ICON_BASE_PATH}/microphone-sensitivity-muted.png"

# Have a different symbol for varying volume levels:
# If volume is muted, display the mute sybol:
if [ "${VOLUME}" == "muted" ]; then
    ICON="${ICON_MUTED}"
    notify-send.sh "Muted" \
        --replace-file=/tmp/audio-notification \
        -t "${TIMEOUT_MS}" \
        -i "${ICON}" \
        -h "int:value:0" \
        -h "string:synchronous:volume-change"
else
    VOLUME=${VOLUME::-1} # remove trailing percent sign
    if [ "${VOLUME}" == "0" ]; then
            ICON="${ICON_MUTED}"
    elif [ "${VOLUME}" -lt "33" ] && [ $VOLUME -gt "0" ]; then
            ICON="${ICON_LOW}"
    elif [ "${VOLUME}" -lt "90" ] && [ $VOLUME -ge "33" ]; then
            ICON="${ICON_MEDIUM}"
    else
            ICON="${ICON_HIGH}"
    fi
    notify-send.sh "Volume: ${VOLUME}%" \
        --replace-file=/tmp/audio-notification \
        -t "${TIMEOUT_MS}" \
        -i "${ICON}" \
        -h "int:value:${VOLUME}" \
        -h "string:synchronous:volume-change"
fi

#killall -s USR1 py3status
py3-cmd refresh volume_status
