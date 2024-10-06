FROM docker.io/ubuntu:20.04
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libcap-dev xz-utils zip \
    unzip strace curl discount git python3 zlib1g-dev \
    libnode-dev libcapnp-dev g++ \
    cmake flex bison locales clang gcc-multilib && apt-get clean
RUN curl -L "https://go.dev/dl/go1.21.6.linux-amd64.tar.gz" -o go.tar.gz  \
    && tar -C /usr/local -xf go.tar.gz \
    && rm go.tar.gz
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/n \
    && bash ~/n v10 \
    && rm -rf ~/n
RUN ln -s /usr/local/n/versions/node/10.24.1/include /usr/local/include/node
ENV PATH "$PATH:/usr/local/go/bin:/usr/local/node/bin:/usr/local/node/include:/usr/local/node/include/node:/usr/local/n/versions/node/10.24.1:/usr/local/n/versions/node/10.24.1/include"
RUN useradd -m file-builder
WORKDIR /sandstorm