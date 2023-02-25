FROM ubuntu:latest

LABEL maintainer="Mohammed Rabil <rabil@techie.com>"

RUN apt-get update && apt-get install -y \
    repo \
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

# Set the working directory to /root
WORKDIR /aosp

CMD ["bash"]