#!/bin/bash

# Get PID from the first argument

# Check if the first argument is a file
if [[ -f $1 ]]; then
    # If it's a file, read PID from the file
    PID=$(cat $1)
else
    # If it's not a file, assume it's a PID value
    PID=$1
fi


# Get output folder from the second argument, or set it to current directory if not provided
OUTPUT_FOLDER=${2:-"."}
OUTPUT_FOLDER=${OUTPUT_FOLDER%/}

# Get timeout from the second argument, or set it to 20 seconds if not provided
TIMEOUT=${3:-5}

# Output file
OUTPUT_FILE="$OUTPUT_FOLDER/monitor.csv"

# Function to retrieve pidstat command output
get_pidstat_output() {
    pidstat -u -r -h -p $PID 1 1
}

echo "Time,CPU,Memory" > $OUTPUT_FILE

CPU_COLUMN=$(get_pidstat_output | tail -n 2 | awk 'NR==1 { for(i=1;i<=NF;i++) if ($i=="%CPU") {print i-1} }')
MEM_COLUMN=$(get_pidstat_output | tail -n 2 | awk 'NR==1 { for(i=1;i<=NF;i++) if ($i=="%MEM") {print i-1} }')

while kill -0 $PID 2> /dev/null; do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    PIDSTAT_OUTPUT=$(get_pidstat_output | tail -n 1)
    CPU_USAGE=$(echo "$PIDSTAT_OUTPUT" | awk -v col="$CPU_COLUMN" '{print $col}')
    MEMORY_USAGE=$(echo "$PIDSTAT_OUTPUT" | awk -v col="$MEM_COLUMN" '{print $col}')
    echo "$TIMESTAMP,$CPU_USAGE,$MEMORY_USAGE" >> $OUTPUT_FILE
    sleep $TIMEOUT
done

echo "Monitored to file $OUTPUT_FILE"
