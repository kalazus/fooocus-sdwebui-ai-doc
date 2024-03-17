#!/bin/false

source /opt/ai-dock/etc/environment.sh
fooocus_git="https://github.com/lllyasviel/Fooocus"

build_common_clone_fooocus() {
    cd /opt
    git clone ${fooocus_git}
}

build_common_clone_fooocus