FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        xz-utils \
        git \
        python2.7 python2.7-dev \
    && ln -sf -T python2.7 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/toolchain

WORKDIR /data/toolchain

RUN git clone https://github.com/juj/emsdk.git

WORKDIR /data/toolchain/emsdk

RUN ./emsdk install latest

RUN ./emsdk activate latest

RUN echo "source /data/toolchain/emsdk/emsdk_env.sh --build=Release" >> ~/.bashrc

RUN mkdir -p /data/project

VOLUME [ "/data/project", "/root/.emscripten_cache" ]

WORKDIR /data/project

CMD [ "/bin/bash" ]
