FROM ubuntu:jammy-20240125

LABEL maintainer="Raymond <zhangyuehua007@gmail.com>"

USER root

RUN  apt-get update &&  \
apt-get install -y curl wget make cmake gcc g++ gdb git clangd \
      libgflags-dev libgoogle-glog-dev libgtest-dev libgmock-dev libboost-all-dev \
      # libevent-dev \
      && rm -rf /var/lib/apt/lists/* \
      && cd / 

# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# RUN useradd --shell /bin/bash raymond
# RUN echo "raymond:root" | chpasswd

# EXPOSE 22

# ENTRYPOINT service ssh start && bash && service ssh status

ENTRYPOINT bash

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
# ENV PYTHONHASHSEED 1