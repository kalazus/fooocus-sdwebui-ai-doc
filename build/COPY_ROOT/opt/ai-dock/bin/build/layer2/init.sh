#!/bin/bash

# Must exit and fail to build if any command fails
set -eo pipefail
umask 002

source /opt/ai-dock/etc/environment.sh
fooocus_git="https://github.com/lllyasviel/Fooocus"

build_common_clone_fooocus() {
    cd /opt
    git clone ${fooocus_git}
}

install_requirements() {
    cd /opt/Fooocus
    sed -i 's/==/>=/g' requirements_versions.txt
    micromamba run -n webui ${PIP_INSTALL} -r requirements_versions.txt
}

build_common_clone_fooocus
install_requirements
fix-permissions.sh -o container