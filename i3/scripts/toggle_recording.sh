#!/bin/bash

RECORDING_PID_FILE="/tmp/gpu-recorder.pid"
OUTPUT_DIR="$HOME/Videos/Recordings"
mkdir -p "$OUTPUT_DIR"

if [ -f "$RECORDING_PID_FILE" ]; then
    # Stop recording
    kill "$(cat $RECORDING_PID_FILE)"
    rm "$RECORDING_PID_FILE"
    notify-send "Recording Stopped"
else
    # Start recording
    TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
    OUTPUT_FILE="$OUTPUT_DIR/recording_$TIMESTAMP.mp4"
    gpu-screen-recorder -w screen -f 40 -a default_output -q medium -o "$OUTPUT_FILE" >/dev/null 2>&1 &
    echo $! > "$RECORDING_PID_FILE"
    notify-send "Recording Started"
fi
