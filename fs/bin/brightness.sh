#!/bin/bash

BASE_CMD="light"
OFFSET=5

case "$1" in
  "up")
    ${BASE_CMD} -A ${OFFSET}
    ;;
  "down")
    ${BASE_CMD} -U ${OFFSET}
    ;;
esac

# notification
VALUE=$(${BASE_CMD} -G)
VOLNOTI_ARGS="-s /usr/share/icons/HighContrast/256x256/status/display-brightness.png"

volnoti-show ${VOLNOTI_ARGS} ${VALUE}

#killall -s USR1 py3status
