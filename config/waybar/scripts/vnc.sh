#!/bin/bash

ENABLED=
DISABLED=

if systemctl is-active --user --quiet vnc.service; then
    printf '{"text": "%s", "class": "enabled", "tooltip": "VNC Enabled"}\n' "$ENABLED"
else
    printf '{"text": "%s", "class": "disabled", "tooltip": "VNC Disabled"}\n' "$DISABLED"
fi
