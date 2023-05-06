FROM ubuntu:22.04

# Install necessary packages available from standard repos
RUN apt-get update -qq && \
    export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    clang \
    clang-tidy \
    clangd \
    cmake \
    cppcheck \
    file \
    g++ \
    gcc \
    gcovr \
    gdb \
    git \
    gpg-agent \
    libclang-dev \
    lld \
    lldb \
    llvm--dev \
    make \
    ninja-build \
    openssh-client \
    parallel \
    python3 \
    python3-pip \
    rsync \
    socat \
    software-properties-common \
    wget \
    zip

RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Include project
ADD . /workspace
WORKDIR /workspace

CMD ["/bin/bash"]
