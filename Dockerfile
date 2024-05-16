FROM alpine:3.19.1

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

ENV ONEPASSWORD_VERSION=2.28.0
ENV TELLER_VERSION=1.5.6
ENV VAULT_VERSION=1.16.2
ENV BUILDEVENTS_VERSION=0.16.0

# hadolint ignore=DL3044
ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl \
    LANG="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# hadolint ignore=DL3003,DL3004,DL4001,SC2035
RUN apk add --no-cache \
        git==2.43.4-r0 \
        openssh==9.6_p1-r0 \
        tar==1.35-r2 \
        gzip==1.13-r0 \
        ca-certificates==20240226-r0 \
        sudo==1.9.15_p2-r0 \
        tzdata==2024a-r0 \
        gettext-dev==0.22.3-r0 \
        libintl==0.22.3-r0 \
        build-base==0.5-r3 \
        musl==1.2.4_git20230717-r4 \
        musl-dev==1.2.4_git20230717-r4 \
        musl-utils==1.2.4_git20230717-r4 \
        gcc==13.2.1_git20231014-r0 \
        g++==13.2.1_git20231014-r0 \
        cmake==3.27.8-r0 \
        make==4.4.1-r2 \
        curl==8.5.0-r0 \
        libcurl==8.5.0-r0 \
        curl-dev==8.5.0-r0 \
        openssl-dev==3.1.4-r6 \
        wget==1.21.4-r0 \
        unzip==6.0-r14 \
        zip==3.0-r12 \
        bzip2=1.0.8-r6 \
        jq==1.7.1-r0 \
        git-lfs==3.4.1-r3 \
        gnupg==2.4.4-r0 \
        docker==25.0.5-r1 \
        openrc==0.52.1-r2 \
        bash==5.2.21-r0

RUN wget -q https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip && \
    unzip musl-locales-master.zip && cd musl-locales-master && \
    cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && \
    make && make install && \
    cd .. && rm -r musl-locales-master* && \
    curl -L https://cache.agilebits.com/dist/1P/op2/pkg/v${ONEPASSWORD_VERSION}/op_linux_amd64_v${ONEPASSWORD_VERSION}.zip -o op.zip && \
    unzip op.zip && sudo mv op /usr/local/bin/op && \
    rm op.zip && rm op.sig && \
    curl -L https://github.com/tellerops/teller/releases/download/v${TELLER_VERSION}/teller_${TELLER_VERSION}_Linux_x86_64.tar.gz --output teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    tar -xzf teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv teller /usr/local/bin/teller && \
    rm teller_${TELLER_VERSION}_Linux_x86_64.tar.gz && \
    curl -SLO "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" > "vault_${VAULT_VERSION}_linux_amd64.zip" && \
    sudo unzip "vault_${VAULT_VERSION}_linux_amd64.zip" -d /usr/local/bin && \
    sudo rm "vault_${VAULT_VERSION}_linux_amd64.zip" && \
    curl -L -o buildevents https://github.com/honeycombio/buildevents/releases/download/v${BUILDEVENTS_VERSION}/buildevents-linux-amd64 && \
    chmod +x buildevents && \
    sudo mv buildevents /usr/local/bin/buildevents && \
    sudo rc-update add docker boot
