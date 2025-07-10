# #!/bin/bash

# # Get cmus status and metadata
# status=$(cmus-remote -Q 2>/dev/null)

# # Check if cmus is running
# if [[ $? -ne 0 ]]; then
#     echo ""
#     exit
# fi

# state=$(echo "$status" | grep "status" | cut -d ' ' -f 2)
# artist=$(echo "$status" | grep "^tag artist" | cut -d ' ' -f 3-)
# title=$(echo "$status" | grep "^tag title" | cut -d ' ' -f 3-)

# if [[ "$state" == "playing" ]]; then
#     echo ">> $artist - $title"
# elif [[ "$state" == "paused" ]]; then
#     echo "-- $artist - $title"
# else
#     echo ""
# fi



#!/bin/bash

# Font Awesome Music Icon
icon1=""
icon2=""

# Get cmus status and metadata
status=$(cmus-remote -Q 2>/dev/null)

# Check if cmus is running
if [[ $? -ne 0 ]]; then
    echo ""
    exit
fi

state=$(echo "$status" | grep "status" | cut -d ' ' -f 2)
artist=$(echo "$status" | grep "^tag artist" | cut -d ' ' -f 3-)
title=$(echo "$status" | grep "^tag title" | cut -d ' ' -f 3-)

if [[ "$state" == "playing" ]]; then
    echo "$icon1 $artist - $title"
elif [[ "$state" == "paused" ]]; then
    echo "$icon2 $artist - $title"
else
    echo ""
fi