FROM google/cloud-sdk:alpine

ENV HOME=/
ENV EDITOR=nvim

RUN apk add neovim && \
    gcloud -q components install kubectl docker-credential-gcr

ENV PATH=$PATH:/.krew/bin

COPY init.sh /init.sh

ENTRYPOINT ["/init.sh"]
