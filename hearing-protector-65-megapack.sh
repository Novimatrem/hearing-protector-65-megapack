#!/bin/bash
cd "$(dirname "$0")"

cd ./my-deps

bash limit-pulseaudio-max-volume-to-65-percent.sh &
bash warning-sound-if-volume-is-65-percent.sh &


