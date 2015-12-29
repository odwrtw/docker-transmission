#!/usr/bin/env bash

[[ "${UID:-""}" =~ ^[0-9]+$ ]] && usermod -u $UID transmission
[[ "${GID:-""}" =~ ^[0-9]+$ ]] && groupmod -g $GID transmission

# Mount permissions
chown -R transmission:transmission /etc/transmission-daemon
chown -R transmission:transmission /downloads

# Run transmission as the transmission user
exec sudo -u transmission \
    /usr/bin/transmission-daemon -g /etc/transmission-daemon --foreground
