FROM alpine:3.20.3

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

# hadolint ignore=DL3044
ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl \
    LANG="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# hadolint ignore=DL3003,DL3004,DL4001,SC2035
RUN apk add --no-cache \
        git==2.45.2-r0 \
        github-cli==2.47.0-r4 \
        openssh==9.7_p1-r4 \
        tar==1.35-r2 \
        gzip==1.13-r0 \
        ca-certificates==20240705-r0 \
        tzdata==2024b-r0 \
        gettext-dev==0.22.5-r0 \
        libintl==0.22.3-r0 \
        build-base==0.5-r3 \
        musl==1.2.5-r0 \
        musl-dev==1.2.5-r0 \
        musl-utils==1.2.5-r0 \
        gcc==13.2.1_git20240309-r0 \
        g++==13.2.1_git20240309-r0 \
        cmake==3.29.3-r0 \
        make==4.4.1-r2 \
        curl==8.10.1-r0 \
        libcurl==8.10.1-r0 \
        curl-dev==8.10.1-r0 \
        openssl-dev==3.3.2-r0 \
        wget==1.24.5-r0 \
        unzip==6.0-r14 \
        zip==3.0-r12 \
        bzip2=1.0.8-r6 \
        jq==1.7.1-r0 \
        git-lfs==3.5.1-r4 \
        gnupg==2.4.5-r0 \
        docker==26.1.5-r0 \
        openrc==0.54-r1 \
        bash==5.2.26-r0 && \
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