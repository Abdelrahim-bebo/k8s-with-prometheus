#!/bin/bash

# Function to send requests
send_requests() {
    while true; do
        curl -sS http://3.93.23.29:30221/ > /dev/null
        echo "Request sent"
        sleep 0.0667  # 1/15 seconds
    done
}

# Start sending requests in the background
for ((i=1; i<=15; i++)); do
    send_requests &
    # Store the process IDs in an array
    pids[$i]=$!
done

# Trap SIGINT (Ctrl+C) to exit gracefully
trap 'echo "Exiting..."; kill ${pids[*]}; exit' INT

# Wait for all background jobs to finish
wait
