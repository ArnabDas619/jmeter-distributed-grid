#!/bin/bash
set -e

echo "JMeter Container Starting..."
echo "Mode: $MODE"

# Function to discover JMeter slaves dynamically
discover_slaves() {
    echo "Discovering JMeter slaves on network..."
    
    # Get all container IPs on the jmeter-net network that match slave pattern
    # Use getent to query DNS for slave service
    SLAVE_HOSTS=""
    
    # Try to discover slaves using Docker's embedded DNS
    # Pattern: <project>-jmeter-slave-<number>
    # We'll try to resolve slaves by iterating through possible indices
    
    MAX_SLAVES=50  # Maximum number of slaves to check
    FOUND_SLAVES=0
    
    for i in $(seq 1 $MAX_SLAVES); do
        # Try both possible naming patterns
        for prefix in "jmeter-distributed-grid-jmeter-slave" "jmeter-slave" "jm-jmeter-slave"; do
            SLAVE_NAME="${prefix}-${i}"
            
            # Try to resolve the hostname
            if getent hosts ${SLAVE_NAME} > /dev/null 2>&1; then
                echo "  ✓ Found slave: ${SLAVE_NAME}"
                
                if [ -z "$SLAVE_HOSTS" ]; then
                    SLAVE_HOSTS="${SLAVE_NAME}"
                else
                    SLAVE_HOSTS="${SLAVE_HOSTS},${SLAVE_NAME}"
                fi
                
                FOUND_SLAVES=$((FOUND_SLAVES + 1))
            fi
        done
    done
    
    if [ $FOUND_SLAVES -eq 0 ]; then
        echo "  ⚠ No slaves found on network"
        SLAVE_HOSTS=""
    else
        echo "  ✓ Total slaves discovered: $FOUND_SLAVES"
    fi
    
    echo "$SLAVE_HOSTS"
}

# Copy custom jmeter.properties if provided
if [ -f /configs/jmeter.properties ]; then
    echo "Loading custom jmeter.properties..."
    cp /configs/jmeter.properties ${JMETER_HOME}/bin/jmeter.properties
fi

# Copy user properties if provided
if [ -f /configs/user.properties ]; then
    echo "Loading custom user.properties..."
    cp /configs/user.properties ${JMETER_HOME}/bin/user.properties
fi

# If specific command is passed, run it
if [ -n "$1" ]; then
    exec "$@"
fi

# Default behavior based on MODE env var
if [ "$MODE" = "SLAVE" ]; then
    echo "Starting JMeter Slave..."
    echo "Hostname: $(hostname)"
    echo "Listening on port 1099 for RMI connections..."
    # -s: run server mode
    # -Dserver.rmi.ssl.disable=true: disable SSL for RMI
    # -Djava.rmi.server.hostname: set hostname for RMI
    jmeter-server \
        -Dserver.rmi.ssl.disable=true \
        -Dserver.rmi.localport=4000 \
        -Dserver_port=1099 \
        -Djava.rmi.server.hostname=$(hostname)
elif [ "$MODE" = "MASTER" ]; then
    echo "Starting JMeter Master..."
    echo ""
    
    # Dynamically discover and configure slaves
    REMOTE_HOSTS=$(discover_slaves)
    
    if [ -n "$REMOTE_HOSTS" ]; then
        echo "Configuring remote_hosts in jmeter.properties..."
        # Update or add remote_hosts in jmeter.properties
        if grep -q "^remote_hosts=" ${JMETER_HOME}/bin/jmeter.properties; then
            # Update existing entry
            sed -i "s/^remote_hosts=.*/remote_hosts=${REMOTE_HOSTS}/" ${JMETER_HOME}/bin/jmeter.properties
        else
            # Add new entry
            echo "remote_hosts=${REMOTE_HOSTS}" >> ${JMETER_HOME}/bin/jmeter.properties
        fi
        
        echo ""
        echo "✓ Configured remote hosts:"
        echo "  ${REMOTE_HOSTS}"
        echo ""
        echo "You can now run distributed tests with:"
        echo "  docker-compose exec jmeter-master jmeter -n -t /scripts/YourTest.jmx -r"
        echo "  (The -r flag automatically uses all discovered slaves)"
    else
        echo "⚠ WARNING: No slaves discovered!"
        echo "Make sure slave containers are running before executing tests."
    fi
    
    echo ""
    echo "Master is ready."
    # Keep container running
    tail -f /dev/null
else
    echo "Please set MODE to MASTER or SLAVE"
    exit 1
fi
