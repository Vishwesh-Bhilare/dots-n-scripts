#!/bin/bash

RECORDING_PID_FILE="/tmp/gpu-recorder.pid"

if [ -f "$RECORDING_PID_FILE" ]; then
    echo "%{F#ff5555}Rec!%{F-}"  # red color
else
    echo ""
fi

