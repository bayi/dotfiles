#!/bin/bash
# A dolgozó switch (SW-Dolgozo-Gep) uplinkjének sebessége. Az értéket az oscontrol írja ide MQTT-ről (HA teszi ki).
# Ha gigabites: a modul üres (nem látszik). Ha visszaesett: piros figyelmeztetés.
F="${XDG_RUNTIME_DIR:-/tmp}/oscontrol/uplink_speed"
S=$(cat "$F" 2>/dev/null)

if [[ "$S" =~ ^[0-9]+$ ]]; then
    if (( S >= 1000 )); then
        printf '{"text": "", "class": "ok", "tooltip": "Switch uplink: %s Mbit/s"}\n' "$S"
    else
        printf '{"text": "⚠ uplink %sM", "class": "degraded", "tooltip": "A switch uplinkje %s Mbit/s-re esett vissza (padláskábel)"}\n' "$S" "$S"
    fi
else
    printf '{"text": "", "class": "unknown", "tooltip": "Switch uplink: nincs adat"}\n'
fi
