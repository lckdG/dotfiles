#!/bin/bash

CURRENT_ENGINE=$(ibus engine)
ENGINES=($(gsettings get org.freedesktop.ibus.general engines-order | grep -oE [A-Za-z:]+))

ENGINE_COUNT=${#ENGINES[@]}
FOUND=0

for i in "${!ENGINES[@]}"; do
    if [[ FOUND -eq "1" ]]; then
        TARGET_ENGINE=${ENGINES[$i]}
    elif [[ "${ENGINES[$i]}" = "${CURRENT_ENGINE}" ]]; then
        FOUND="1"
    fi
done

if [[ ! FOUND -eq "1" ]]; then
    TARGET_ENGINE=${ENGINES[0]}
fi

ibus engine $TARGET_ENGINE

