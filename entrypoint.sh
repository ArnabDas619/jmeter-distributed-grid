#!/bin/bash
set -e

# If specific command is passed, run it
if [ -n "$1" ]; then
    exec "$@"
fi

# Default behavior based on MODE env var
if [ "$MODE" = "SLAVE" ]; then
    echo "Starting JMeter Slave..."
    # -s: run server
    # -j: jmeter log file
    jmeter -s -j /var/log/jmeter-server.log
elif [ "$MODE" = "MASTER" ]; then
    echo "Starting JMeter Master..."
    # Keep container running or run a test if mounted
    tail -f /dev/null
else
    echo "Please set MODE to MASTER or SLAVE"
    exit 1
fi
