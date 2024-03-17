ARG IMAGE_BASE="ghcr.io/ai-dock/stable-diffusion-webui:pytorch-2.2.0-py3.10-cuda-11.8.0-runtime-22.04"
FROM ${IMAGE_BASE}

LABEL org.opencontainers.image.source https://github.com/kalazus/fooocus-sdwebui-ai-doc
LABEL org.opencontainers.image.description "Automatic1111+Fooocus Web UI"

COPY --chown=0:1111 --chmod=755 ./COPY_ROOT/ /
RUN set -eo pipefail && /opt/ai-dock/bin/build/layer2/init.sh

CMD ["init.sh"]

