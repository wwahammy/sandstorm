FROM docker.io/ubuntu:20.04
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install -y build-essential libcap-dev xz-utils zip \
    unzip strace curl discount git python3 zlib1g-dev \
    cmake flex bison locales clang gcc-multilib g++ jq xz-utils && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L "https://go.dev/dl/go1.21.6.linux-amd64.tar.gz" -o go.tar.gz  \
    && tar -C /usr/local -xf go.tar.gz \
    && rm go.tar.gz
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/n \
    && bash ~/n v10 \
    && rm -rf ~/n
ENV PATH "$PATH:/usr/local/go/bin"
RUN groupadd -g 1000 file-builder
RUN useradd -m -g 1000 -u 1000 file-builder
RUN chown -R  file-builder:file-builder /usr/local
USER file-builder
RUN curl https://install.meteor.com/?release=2.3.5 | sh
USER root
RUN chown -R  root:root /usr/local
USER file-builder
ENV PATH $PATH:/home/file-builder/.meteor
ENV METEOR_WAREHOUSE_DIR /home/file-builder/.meteor
WORKDIR /sandstorm