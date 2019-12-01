#!/usr/bin/env bash

MICROK8S_VERSION="1.16/stable"
SNAPD_VERSION="2.21-2+b1"
DOCKER_VERSION="5:19.03.5~3-0~debian-stretch"

# install snapd
apt update -y -qqq
apt install -y -qqq snapd=${SNAPD_VERSION} 

# set snap to the PATH
if [[ ! $PATH =~ "/snap/bin" ]]; then
    echo "Adding '/snap/bin' to PATH."
    export PATH=$PATH:/snap/bin
fi

# install microk8s
snap install core
snap install microk8s --channel=${MICROK8S_VERSION} --classic

# enable microk8s components
microk8s.enable helm dns

# install docker
apt -y -qqq install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     bats

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get -y -qqq update
apt-get -y -qqq install docker-ce=${DOCKER_VERSION}
