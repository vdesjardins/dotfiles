FROM google/cloud-sdk:latest

RUN apt-get update && \
  apt-get install -y vim-nox && \
  apt-get --purge -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

