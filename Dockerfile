FROM ubuntu:latest as aosp_base

LABEL maintainer="Mohammed Rabil <rabil@techie.com>"

RUN apt-get update && apt-get install -y \
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    libc6-dev-i386 \
    libncurses5 \
    lib32ncurses5-dev \
    x11proto-core-dev \
    libx11-dev \
    lib32z1-dev \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    openssl \
    libssl-dev \
    fontconfig \
    jq \
    openjdk-8-jdk \
    gperf \
    python-is-python3 \
    ccache

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup CCACHE
ENV USE_CCACHE=1
# Find the path to the ccache binary
RUN export CCACHE_PATH=$(which ccache)

# Install repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && chmod a+x /usr/local/bin/repo

FROM aosp_base as aosp_build
WORKDIR /aosp

CMD ["bash"]