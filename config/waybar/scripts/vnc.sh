#!/bin/bash

ENABLED=
DISABLED=

if systemctl is-active --user --quiet stream.service; then
    VIEWERS=$(cat "${XDG_RUNTIME_DIR:-/tmp}/stream-viewers" 2>/dev/null)
    TEXT="$ENABLED"
    [ "${VIEWERS:-0}" -gt 0 ] 2>/dev/null && TEXT="$ENABLED $VIEWERS"
    printf '{"text": "%s", "class": "enabled", "tooltip": "Stream megy (vnc.bayi.hu), nézők: %s"}\n' "$TEXT" "${VIEWERS:-?}"
else
    printf '{"text": "%s", "class": "disabled", "tooltip": "Stream áll"}\n' "$DISABLED"
fi
