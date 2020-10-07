FROM google/cloud-sdk:alpine

ARG HELM_VERSION=v3.3.4
ARG GCS_PLUGIN_VERSION=0.3.6
ARG DIFF_PLUGIN_VERSION=v3.1.3

ENV HOME=/home
ENV XDG_CACHE_HOME=/home/.cache
ENV XDG_CONFIG_HOME=/home/.config
ENV XDG_DATA_HOME=/home/.local/share

RUN mkdir -p /helm && \
  mkdir -p /home && \
  apk add ca-certificates && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /helm linux-amd64 && \
  rm helm.tar.gz && \
  /helm/helm plugin install https://github.com/nouney/helm-gcs --version ${GCS_PLUGIN_VERSION} && \
  /helm/helm plugin install https://github.com/databus23/helm-diff --version ${DIFF_PLUGIN_VERSION}

ENV PATH=/helm/:$PATH

ENTRYPOINT ["helm"]
