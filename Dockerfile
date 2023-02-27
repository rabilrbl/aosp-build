FROM ubuntu:latest as aosp_base

SHELL [ "bash", "-c" ]

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
RUN sudo curl -s https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo \
        && sudo chmod a+x /usr/local/bin/repo \
        && repo --version

# Download and install latest LLVM tools
RUN sudo curl -s https://apt.llvm.org/llvm.sh > /tmp/llvm.sh \
        && sudo chmod a+x /tmp/llvm.sh \
        && sudo /tmp/llvm.sh \
        && export LLVM_VERSION=$(cat /tmp/llvm.sh | grep -oP 'CURRENT_LLVM_STABLE=(\K[0-9.]+)') \
        && for i in $(ls /usr/lib/llvm-$LLVM_VERSION/bin) ; do sudo ln -s /usr/lib/llvm-$LLVM_VERSION/bin/$i /usr/bin/$i ; done \
        && sudo rm /tmp/llvm.sh

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

CMD [ "bash", "-c" ]
