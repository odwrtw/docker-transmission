#!/bin/sh

[ "$TRANSMISSION_UID" ] && usermod -u "$TRANSMISSION_UID" transmission
[ "$TRANSMISSION_GID" ] && groupmod -g "$TRANSMISSION_GID" transmission

TRANSMISSION_CONFIG_DIR="/etc/transmission-daemon"
[ -d "$TRANSMISSION_CONFIG_DIR" ] || mkdir -p "$TRANSMISSION_CONFIG_DIR"

# Mount permissions
chown -R transmission:transmission "$TRANSMISSION_CONFIG_DIR"
chown -R transmission:transmission /downloads

# Run transmission as the transmission user
exec su -c "/usr/bin/transmission-daemon --config-dir $TRANSMISSION_CONFIG_DIR --foreground" - transmission
