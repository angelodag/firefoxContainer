#!/bin/bash
set -e
xhost +local:docker

docker run -it --rm  \
  --device /dev/snd   \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native  \
  -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native  \
  -v ~/.config/pulse/cookie:/root/.config/pulse/cookie --group-add $(getent group audio | cut -d: -f3) -e DISPLAY=unix$DISPLAY -e USER_ID=$UID -e GROUP_ID=$UID \
  -v $HOME/Downloads:/root/Downloads \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name firefox --shm-size 2g  firefox:latest
