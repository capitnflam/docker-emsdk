FROM debian:jessie-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        git \
        wget \
        python2.7 python2.7-dev \
    && ln -sf -T python2.7 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://cmake.org/files/v3.10/cmake-3.10.1-Linux-x86_64.tar.gz \
    && tar xf cmake-3.10.1-Linux-x86_64.tar.gz \
    && cp -R cmake-3.10.1-Linux-x86_64/* / \
    && rm -rf cmake-3.10.1-Linux-x86_64 cmake-3.10.1-Linux-x86_64.tar.gz

RUN mkdir -p /data/toolchain

WORKDIR /data/toolchain

RUN git clone https://github.com/juj/emsdk.git

WORKDIR /data/toolchain/emsdk

RUN ./emsdk install --build=Release sdk-incoming-64bit binaryen-master-64bit

RUN ./emsdk activate --build=Release sdk-incoming-64bit binaryen-master-64bit

RUN echo "source /data/toolchain/emsdk/emsdk_env.sh --build=Release" >> ~/.bashrc

RUN mkdir -p /data/project

VOLUME [ "/data/project" ]

WORKDIR /data/project

CMD [ "/bin/bash" ]
