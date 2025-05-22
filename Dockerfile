FROM alpine:3.21.3

LABEL org.opencontainers.image.title="gha-container-base-image" \
      org.opencontainers.image.description="Alpine-based github actions job container image" \
      org.opencontainers.image.documentation="https://github.com/ThoughtWorks-DPS/gha-container-base-image" \
      org.opencontainers.image.source="https://github.com/ThoughtWorks-DPS/gha-container-base-image" \
      org.opencontainers.image.url="https://github.com/ThoughtWorks-DPS/gha-container-base-image" \
      org.opencontainers.image.vendor="ThoughtWorks, Inc." \
      org.opencontainers.image.authors="nic.cheneweth@thoughtworks.com" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.created="CREATED" \
      org.opencontainers.image.version="VERSION"

ENV ONEPASSWORD_VERSION=2.30.0
ENV TELLER_VERSION=1.5.6
ENV VAULT_VERSION=1.18.0
ENV BUILDEVENTS_VERSION=0.16.0

ENV LANG="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# hadolint ignore=DL3003,DL3004,DL4001,SC2035
RUN apk add --no-cache \
        git \
        github-cli \
        openssh \
        tar \
        gzip \
        ca-certificates \
        tzdata \
        gettext-dev \
        build-base \
        musl \
        musl-dev \
        musl-utils \
        gcc \
        g++ \
        cmake \
        make \
        curl \
        libcurl \
        curl-dev \
        openssl-dev \
        wget \
        unzip \
        zip \
        bzip2 \
        jq \
        git-lfs \
        gnupg \
        docker \
        openrc \
        bash && \
    wget -q https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip && \
    unzip musl-locales-master.zip && cd musl-locales-master && \
    cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && \
    make && make install && \
    cd .. && rm -r musl-locales-master* && \
    curl -L https://cache.agilebits.com/dist/1P/op2/pkg/v${ONEPASSWORD_VERSION}/op_linux_amd64_v${ONEPASSWORD_VERSION}.zip -o op.zip && \
    unzip op.zip && mv op /usr/local/bin/op && \
    rm op.zip && rm op.sig && \
    curl -L https://github.com/tellerops/teller/releases/download/v${TELLER_VERSION}/teller_${TELLER_VERSION}_Linux_x86_64.tar.gz --output teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    tar -xzf teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    mv teller /usr/local/bin/teller && \
    rm teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    curl -SLO "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" > "vault_${VAULT_VERSION}_linux_amd64.zip" && \
    unzip "vault_${VAULT_VERSION}_linux_amd64.zip" -d /usr/local/bin && \
    rm "vault_${VAULT_VERSION}_linux_amd64.zip" && \
    curl -L -o buildevents https://github.com/honeycombio/buildevents/releases/download/v${BUILDEVENTS_VERSION}/buildevents-linux-amd64 && \
    chmod +x buildevents && \
    mv buildevents /usr/local/bin/buildevents && \
    rc-update add docker boot
