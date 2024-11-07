#!/usr/bin/env bash

xhost +Local:* # adds non-network local connections to access control list (for container to access display)

# stops mosquitto service on host for releasing port 1883
systemctl is-active --quiet mosquitto && echo "Stopping mosquitto on host." && systemctl stop mosquitto && echo "Stopped."

args=("$@")
export ABSPATH_APP_DIR=$(cd ${args[0]} && pwd)

export GROUP_AUDIO_ID=$(getent group audio | cut -d: -f3)

# Remove the first argument (ABSPATH_APP_DIR) from the args array
unset args[0]

# Initialize a new array to hold the modified arguments
modified_args=()

# Flags to check for image presence
contains_handpose=false
contains_face=false

# Loop through the arguments to check for handpose_recognition and face_recognition
for arg in "${args[@]}"; do
    if [[ "$arg" == "handpose" ]]; then
        contains_handpose=true
    elif [[ "$arg" == "frecog" ]]; then
        contains_face=true
    else
        modified_args+=("$arg")  # Add other arguments to the new array
    fi
done

# Modify the args array if both images are present
if $contains_handpose && $contains_face; then
    modified_args+=("vcam-modules")  # Add "vcam-modules"
else
    # If only one is present, keep it in the modified_args array
    if $contains_handpose; then
        modified_args+=("handpose")  # Keep "handpose"
    elif $contains_face; then
        modified_args+=("frecog")  # Keep "frecog"
    fi
fi

# Call docker compose up with ginga and any other arguments provided
docker compose up --build ginga "${modified_args[@]}"

# Remove any exited containers
docker compose rm -fsv
