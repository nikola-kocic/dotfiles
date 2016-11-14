#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

export XAUTHORITY=/home/kocic/.Xauthority
export DISPLAY=:0

args=()

function turn_on_docked_displays()
{
    args+=(--output DP1 --mode 1920x1080 --pos 1920x0 --rotate normal)
    args+=(--output DP2 --mode 1920x1080 --pos 0x0 --rotate normal)
}

function turn_off_docked_displays()
{
    args+=(--output DP1 --off --output DP2 --off)
}

function turn_on_laptop_display()
{
    args+=(--output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal)
}

function turn_off_laptop_display()
{
    args+=(--output eDP1 --off)
}

#DOCK_MONITOR_STATUS=$(cat /sys/class/drm/card0-DP-1/status)  # connected or disconnected
DP1_CONNECTED_STRING=$(xrandr | grep  "^DP1 connected") || $(echo "")  # empty or not empty

echo "DP1_CONNECTED_STRING=${DP1_CONNECTED_STRING}"

if [[ -z $DP1_CONNECTED_STRING ]] ; then
  turn_off_docked_displays
else
  turn_on_docked_displays
fi

LID_STATUS=$(cat /proc/acpi/button/lid/LID0/state | cut -d' ' -f2- | sed 's/^ *//')  # open or closed
echo "LID_STATUS=${LID_STATUS}"

if [ "${LID_STATUS}" == "open" ] ; then
  turn_on_laptop_display
elif [ "${LID_STATUS}" == "closed" ] ; then
  turn_off_laptop_display
else
  exit
fi

args+=(--output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output VGA1 --off  --output VIRTUAL1 --off)

xrandr "${args[@]}"
