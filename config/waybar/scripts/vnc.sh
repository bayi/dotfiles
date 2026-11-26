#!/bin/bash

ENABLED=
DISABLED=

if systemctl is-active --user --quiet stream.service; then
    printf '{"text": "%s", "class": "enabled", "tooltip": "Stream megy (vnc.bayi.hu)"}\n' "$ENABLED"
else
    printf '{"text": "%s", "class": "disabled", "tooltip": "Stream áll"}\n' "$DISABLED"
fi
