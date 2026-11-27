#!/bin/bash

ENABLED=
DISABLED=

if systemctl is-active --user --quiet stream.service; then
    VIEWERS=$(cat "${XDG_RUNTIME_DIR:-/tmp}/stream-viewers" 2>/dev/null)
    TEXT="$ENABLED"
    SOUND="csak kép"
    if [ "$(cat "${XDG_RUNTIME_DIR:-/tmp}/stream-scene" 2>/dev/null)" = "Megosztas-hanggal" ]; then TEXT="$ENABLED 󰕾"; SOUND="HANGGAL"; fi
    [ "${VIEWERS:-0}" -gt 0 ] 2>/dev/null && TEXT="$TEXT $VIEWERS"
    printf '{"text": "%s", "class": "enabled", "tooltip": "Stream megy (vnc.bayi.hu, %s), nézők: %s"}\n' "$TEXT" "$SOUND" "${VIEWERS:-?}"
else
    printf '{"text": "%s", "class": "disabled", "tooltip": "Stream áll — bal klikk: csak kép, középső klikk: a gép hangjával, jobb klikk: stop"}\n' "$DISABLED"
fi
