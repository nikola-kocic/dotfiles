#!/usr/bin/env bash

TIMEOUT_MS=1000
ICON_BASE_PATH="/usr/share/icons/HighContrast/22x22/status"
ICON_HIGH="${ICON_BASE_PATH}/audio-volume-high.png"
ICON_MEDIUM="${ICON_BASE_PATH}/audio-volume-medium.png"
ICON_LOW="${ICON_BASE_PATH}/audio-volume-low.png"
ICON_MUTED="${ICON_BASE_PATH}/audio-volume-muted.png"

PRIMARY_SINK="alsa_output.usb-Yamaha_Corporation_Steinberg_UR22mkII-00.iec958-stereo"
BASE_CMD="pamixer --sink ${PRIMARY_SINK}"
BASE_SINK_CMD="pamixer --sink"
STEP=5

ALL_SINKS=$(pacmd list-sinks | sed -n 's/.*name: <\(.*\)>/\1/p')

SINKS=()
for SINK in ${ALL_SINKS[@]}; do
    # if [ "${SINK}" != "echoCancel_sink" ]; then
        SINKS+=( ${SINK} )
    # fi
done

PRIMARY_SINK_VOLUME=$(${BASE_SINK_CMD} ${PRIMARY_SINK} --get-volume-human)
MUTED=0

case "$1" in
  "up")
    for SINK in ${SINKS[@]}; do
        if [ "${SINK}" != "echoCancel_sink" ]; then
            ${BASE_SINK_CMD} ${SINK} --increase ${STEP}
        fi
    done
    ;;
  "down")
    for SINK in ${SINKS[@]}; do
        if [ "${SINK}" != "echoCancel_sink" ]; then
            ${BASE_SINK_CMD} ${SINK} --decrease ${STEP}
        fi
    done
    ;;
  "mute")
    if [ "${PRIMARY_SINK_VOLUME}" == "muted" ]; then
        for SINK in ${SINKS[@]}; do
            ${BASE_SINK_CMD} ${SINK} --unmute
        done
    else
        for SINK in ${SINKS[@]}; do
            ${BASE_SINK_CMD} ${SINK} --mute
            MUTED=1
        done
    fi
    #"${HOME}/fs/bin/change-volume-of-all" mute
    ;;
esac

# Have a different symbol for varying volume levels:
# If volume is muted, display the mute sybol:
if [ "${MUTED}" == "1" ]; then
    for SINK in ${SINKS[@]}; do
        echo "${BASE_SINK_CMD} ${SINK} --mute"
        ${BASE_SINK_CMD} ${SINK} --mute
    done
    ICON="${ICON_MUTED}"
    notify-send.sh "Muted" \
        --replace-file=/tmp/audio-notification \
        -t "${TIMEOUT_MS}" \
        -i "${ICON}" \
        -h "int:value:0" \
        -h "string:synchronous:volume-change"
else
    VOLUMES_STRING="Volume: "
    for SINK in ${SINKS[@]}; do
        VOLUME=$(${BASE_SINK_CMD} ${SINK} --get-volume-human)
        VOLUME=${VOLUME::-1} # remove trailing percent sign
        VOLUMES_STRING="${VOLUMES_STRING} ${VOLUME}% "
    done

    # if [ "${VOLUME}" == "0" ]; then
    #     ICON="${ICON_MUTED}"
    # elif [ "${VOLUME}" -lt "33" ] && [ $VOLUME -gt "0" ]; then
    #     ICON="${ICON_LOW}"
    # elif [ "${VOLUME}" -lt "90" ] && [ $VOLUME -ge "33" ]; then
    #     ICON="${ICON_MEDIUM}"
    # else
    ICON="${ICON_HIGH}"
    # fi
    notify-send.sh "${VOLUMES_STRING}" \
        --replace-file=/tmp/audio-notification \
        -t "${TIMEOUT_MS}" \
        -i "${ICON}" \
        -h "string:synchronous:volume-change"
        #-h "int:value:${VOLUME}" \
fi

#killall -s USR1 py3status
py3-cmd refresh volume_status

#if [ "${VOLUME}" == "muted" ]; then
#  volnoti-show --mute
#else
#  volnoti-show ${VOLUME}
#fi
