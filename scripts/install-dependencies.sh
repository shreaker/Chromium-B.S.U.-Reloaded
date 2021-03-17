#!/bin/bash

set -Eeuo pipefail #bash strict mode

if [ $UID -ne 0 ]; then
    echo "must be run as root"
    exit 1
fi

fail() {
    echo process failed!
    exit 1
}

trap fail ERR SIGINT SIGTERM SIGKILL

apt update

# SFML Dependencies
apt install -y libpthread-stubs0-dev libgl1-mesa-dev libx11-dev libxrandr-dev libfreetype6-dev libglew1.5-dev libjpeg8-dev libsndfile1-dev libopenal-dev libudev-dev

# SFML Dependencies Joystick
apt install -y libudev-dev
