#!/bin/sh
echo "set urgent to $1" >> /tmp/set_urgent.log
if [[ $1 == "Konsole" ]]; then
    # Konsole itself sets urgent hint to a proper window
    exit 0
fi
wmctrl -r $1 -b add,demands_attention
