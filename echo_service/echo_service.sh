#!/bin/bash

OUTPUT_FILE="date.log"

PID_FILE="echo.pid"

# Write the PID to the PID file
echo "$$" > "$PID_FILE"

# Loop indefinitely
while true; do
    # Get the current date and time
    current_date=$(date '+%Y-%m-%d %H:%M:%S')

    # Write the date to the output file
    echo "$current_date" >> "$OUTPUT_FILE"

    # Sleep for 1 minute
    sleep 5
done
