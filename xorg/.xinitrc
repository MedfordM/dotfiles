#!/bin/bash

rfkill unblock bluetooth
nvidia-settings --load-config-only
xrdb -merge ~/.Xresources
xset r rate 200 30
