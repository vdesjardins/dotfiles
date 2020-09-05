FROM google/cloud-sdk:alpine

ARG TF_VERSION
ARG TF_SHA256SUM

ENV TERRAFORM_VERSION=${TF_VERSION}
ENV TERRAFORM_VERSION_SHA256SUM=${TF_SHA256SUM}

ENV HOME=/home
ENV XDG_CACHE_HOME=/home/.cache
ENV XDG_CONFIG_HOME=/home/.config
ENV XDG_DATA_HOME=/home/.local/share

RUN gcloud -q components install kubectl docker-credential-gcr && \
    apk add ca-certificates jq && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
      > terraform_linux_amd64.zip && \
    echo "${TERRAFORM_VERSION_SHA256SUM}  terraform_linux_amd64.zip" > terraform_SHA256SUMS && \
    sha256sum -c terraform_SHA256SUMS -s && \
    mkdir -p /terraform && \
    unzip terraform_linux_amd64.zip -d /terraform && \
    rm -f terraform_linux_amd64.zip

COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

ENV HELM_VERSION=v3.3.0
ENV GCS_PLUGIN_VERSION=0.3.6

RUN mkdir -p /helm && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /helm linux-amd64/helm && \
  rm helm.tar.gz && \
  rm -rf /var/lib/apt/lists/* && \
  /helm/helm plugin install https://github.com/nouney/helm-gcs --version ${GCS_PLUGIN_VERSION}

ENV PATH=/terraform/:/helm/:$PATH

ENTRYPOINT ["terraform"]
