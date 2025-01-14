FROM mcr.microsoft.com/devcontainers/base:jammy

# Install additional tools
RUN sudo apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    sudo apt-get -y install --no-install-recommends \
    jq \
    curl \
    git \
    unzip \
    software-properties-common \
    make && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/*

# Install tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Install tfupdate
#TODO: Pin version tag for tfupdate
RUN curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest | \
  grep -o -E -m 1 "https://.+?_linux_amd64.tar.gz" | \
  xargs curl -L > tfupdate.tar.gz && \
  tar -xzf tfupdate.tar.gz tfupdate && \
  rm tfupdate.tar.gz && \
  sudo mv tfupdate /usr/bin/

# Create workspace directory
WORKDIR /workspace
