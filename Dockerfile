FROM ubuntu:latest as aosp_base

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m aospb && echo "aospb:aospb" | chpasswd && adduser aospb sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER aospb

WORKDIR /home/aospb

RUN sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -y \
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
    openjdk-8-jdk \
    gperf \
    python3 \
    python-is-python3 \
    ccache

# Setup CCACHE
ENV USE_CCACHE=1
# Find path to ccache
RUN export CCACHE_PATH=$(which ccache)

# Setup git config
ARG GIT_NAME="KernelB"
ENV GIT_NAME=${GIT_NAME}
ARG GIT_EMAIL="20230226+kernelb@users.noreply.github.com"
ENV GIT_EMAIL=${GIT_EMAIL}
RUN git config --global user.name "${GIT_NAME}"
RUN git config --global user.email "${GIT_EMAIL}"
# Enable color output (optional)
RUN git config --global color.ui true
# Pull rebase by default or supply ARG PULL_REBASE=false
ARG PULL_REBASE=true
ENV PULL_REBASE=${PULL_REBASE}
RUN git config --global pull.rebase ${PULL_REBASE}

# Install and setup latest repo, if needed
RUN mkdir -p ~/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo \
     && chmod a+x ~/bin/repo && export PATH=~/bin:$PATH \
     && echo "export PATH=~/bin:$PATH" >> ~/.bashrc && source ~/.bashrc \
     && repo --version

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "bash", "-c" ]
