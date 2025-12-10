#!/bin/bash

# Change the install root here
UNITY_EDITOR_ROOT=${HOME}/Unity/Hub/Editor/*

for EDITOR_DIR in $(ls -d ${UNITY_EDITOR_ROOT}); do
    ANDROID_DIR=${EDITOR_DIR}/Editor/Data/PlaybackEngines/AndroidPlayer

    if [ -d ${ANDROID_DIR} ]; then
        if [ ! -f ${ANDROID_DIR}/modules.asset ]; then
            # Extract the downloaded Payload~ file, Unity hook seems broken
            7z x -y ${ANDROID_DIR}/Payload~ -o${ANDROID_DIR}
            echo "Extracted Payload~"
        fi

        # Replace broken symlinks with the correct one
        # namely removing the android-ndk-<version> directory
        NDK_DIR=${ANDROID_DIR}/NDK

        for FILE in $(find ${NDK_DIR} -type l -xtype l); do
            LINK=$(readlink ${FILE} | sed -E 's/android-ndk-[A-Za-z0-9]+\///')
            ln -sfn ${LINK} ${FILE}

            echo "Attempted to fix broken link of $LINK"
        done
    fi
done

