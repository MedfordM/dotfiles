#!/bin/bash

if [ "$1" = "Speakers" ]; then
  pactl set-default-sink alsa_output.usb-Generic_USB_Audio-00.HiFi__hw_Audio__sink
elif [ "$1" = "Headphones" ]; then
  pactl set-default-sink alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.pro-output-0
fi


