FROM gcr.io/cloud-builders/gcloud

ARG HELM_VERSION=v3.1.0
ARG GCS_PLUGIN_VERSION=0.3.1
ARG DIFF_PLUGIN_VERSION=v3.1.0

COPY helm.bash /builder/helm.bash

ENV XDG_CACHE_HOME=/builder/home/.cache
ENV XDG_CONFIG_HOME=/builder/home/.config
ENV XDG_DATA_HOME=/builder/home/.local/share

RUN chmod +x /builder/helm.bash && \
  mkdir -p /builder/helm && \
  mkdir -p /builder/home && \
  apt-get update && \
  apt-get install -y curl ca-certificates && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /builder/helm linux-amd64 && \
  rm helm.tar.gz && \
  apt-get --purge -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  /builder/helm/helm plugin install https://github.com/nouney/helm-gcs --version ${GCS_PLUGIN_VERSION} && \
  /builder/helm/helm plugin install https://github.com/databus23/helm-diff --version ${DIFF_PLUGIN_VERSION}

ENV PATH=/builder/helm/:$PATH

ENTRYPOINT ["/builder/helm.bash"]
