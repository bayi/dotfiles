#!/bin/bash

ENABLED=
DISABLED=

if systemctl is-active --user --quiet animated-bg@HDMI-A-2.service; then
    printf '{"text": "%s", "class": "enabled", "tooltip": "Enabled"}\n' "$ENABLED"
else
    printf '{"text": "%s", "class": "disabled", "tooltip": "Disabled"}\n' "$DISABLED"
fi
