#!/bin/false
# This file will be sourced in init.sh

function preflight_main() {
    printf "%s" "${FOOOCUS_FLAGS}" > /etc/fooocus_flags.conf
}

preflight_main "$@"