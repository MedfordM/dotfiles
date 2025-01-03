#!/bin/bash

HEADPHONES='alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.analog-stereo'
SPEAKERS='alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink'

# Get current default
if [[ -z $1 ]]; then
  CURRENT=$(pactl get-default-sink)
  if [ "$CURRENT" = $HEADPHONES ]; then
    echo "Headphones"
  elif [ "$CURRENT" = $SPEAKERS ]; then
    echo "Speakers"
  fi
  return
fi

# Update default
if [ "$1" = "Speakers" ]; then
  pactl set-default-sink $SPEAKERS
elif [ "$1" = "Headphones" ]; then
  pactl set-default-sink $HEADPHONES
fi

# Move any stragglers over
CURRENT=$(pactl get-default-sink)
SINK_INPUTS=$(pactl list sink-inputs | awk -F '#' '/Sink Input #/ {print $2}')
for SINK_INPUT in $SINK_INPUTS; do
  pactl move-sink-input $SINK_INPUT $CURRENT
done

