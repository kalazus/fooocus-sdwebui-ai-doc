#!/bin/bash

trap cleanup EXIT

LISTEN_PORT=${FOOOCUS_PORT_LOCAL:-17870}
METRICS_PORT=${FOOOCUS_METRICS_PORT:-27870}
PROXY_SECURE=true

function cleanup() {
    kill $(jobs -p) > /dev/null 2>&1
    rm /run/http_ports/$PROXY_PORT > /dev/null 2>&1
}

function start() {
    if [[ ! -v FOOOCUS_PORT || -z $FOOOCUS_PORT ]]; then
        FOOOCUS_PORT=${FOOOCUS_PORT_HOST:-7870}
    fi
    PROXY_PORT=$FOOOCUS_PORT
    SERVICE_NAME="Fooocus Web UI"
    
    file_content="$(
      jq --null-input \
        --arg listen_port "${LISTEN_PORT}" \
        --arg metrics_port "${METRICS_PORT}" \
        --arg proxy_port "${PROXY_PORT}" \
        --arg proxy_secure "${PROXY_SECURE,,}" \
        --arg service_name "${SERVICE_NAME}" \
        '$ARGS.named'
    )"
    
    printf "%s" "$file_content" > /run/http_ports/$PROXY_PORT
    
    printf "Starting $SERVICE_NAME...\n"

    # No longer skipping prepare-environment
    BASE_FLAGS=""
    
    # Delay launch until micromamba is ready
    if [[ -f /run/workspace_sync || -f /run/container_config ]]; then
        kill $(lsof -t -i:$LISTEN_PORT) > /dev/null 2>&1 &
        wait -n
        /usr/bin/python3 /opt/ai-dock/fastapi/logviewer/main.py \
            -p $LISTEN_PORT \
            -r 5 \
            -s "${SERVICE_NAME}" \
            -t "Preparing ${SERVICE_NAME}" &
        fastapi_pid=$!
        
        while [[ -f /run/workspace_sync || -f /run/container_config ]]; do
            sleep 1
        done
        
        kill $fastapi_pid
        wait $fastapi_pid 2>/dev/null
    fi
    
    kill $(lsof -t -i:$LISTEN_PORT) > /dev/null 2>&1 &
    wait -n
    
    FLAGS_COMBINED="${BASE_FLAGS} $(cat /etc/fooocus_flags.conf)"
    printf "Starting %s...\n" "${SERVICE_NAME}"
    
    cd /opt/Fooocus &&
    exec micromamba run -n webui -e python launch.py \
        ${FLAGS_COMBINED} --port ${LISTEN_PORT}
}

start 2>&1