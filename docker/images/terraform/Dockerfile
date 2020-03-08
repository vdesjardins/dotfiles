# see https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/terraform
# see https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/helm
FROM gcr.io/cloud-builders/gcloud

ARG TF_VERSION
ARG TF_SHA256SUM

ENV HELM_VERSION=v3.1.0
ENV TERRAFORM_VERSION=${TF_VERSION}
ENV TERRAFORM_VERSION_SHA256SUM=${TF_SHA256SUM}
ENV GCS_PLUGIN_VERSION=0.3.1

ENV XDG_CACHE_HOME=/builder/home/.cache
ENV XDG_CONFIG_HOME=/builder/home/.config
ENV XDG_DATA_HOME=/builder/home/.local/share

RUN /builder/google-cloud-sdk/bin/gcloud -q components update && \
    apt-get update && \
    apt-get -y install curl unzip ca-certificates jq && \
    apt-get --purge -y autoremove && \
    apt-get clean && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
      > terraform_linux_amd64.zip && \
    echo "${TERRAFORM_VERSION_SHA256SUM} terraform_linux_amd64.zip" > terraform_SHA256SUMS && \
    sha256sum -c terraform_SHA256SUMS --status && \
    unzip terraform_linux_amd64.zip -d /builder/terraform && \
    rm -f terraform_linux_amd64.zip

COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

RUN mkdir -p /builder/helm && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /builder/helm linux-amd64/helm && \
  rm helm.tar.gz && \
  rm -rf /var/lib/apt/lists/* && \
  /builder/helm/helm plugin install https://github.com/nouney/helm-gcs --version ${GCS_PLUGIN_VERSION}

ENV PATH=/builder/terraform/:/builder/helm/:$PATH

COPY entrypoint.bash /builder/entrypoint.bash

ENTRYPOINT ["/builder/entrypoint.bash"]

