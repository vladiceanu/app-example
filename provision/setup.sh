#!/usr/bin/env bash

MICROK8S_VERSION="1.16/stable"
SNAPD_VERSION="2.21-2+b1"
DOCKER_VERSION="5:19.03.5~3-0~debian-stretch"

# install snapd
sudo apt update -y -qqq
sudo apt install -y -qqq snapd=${SNAPD_VERSION} 

# install microk8s
sudo snap install core
sudo snap install microk8s --channel=${MICROK8S_VERSION} --classic

# enable microk8s components
/snap/bin/microk8s.enable helm dns

# install docker
sudo apt -y -qqq install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     bats

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y -qqq update
sudo apt-get -y -qqq install docker-ce=${DOCKER_VERSION}

sudo usermod -a -G microk8s $(whoami)
sudo usermod -a -G docker $(whoami)

echo """
       _______ _______ ______ _   _ _______ _____ ____  _   _ 
    /\|__   __|__   __|  ____| \ | |__   __|_   _/ __ \| \ | |
   /  \  | |     | |  | |__  |  \| |  | |    | || |  | |  \| |
  / /\ \ | |     | |  |  __| | .   |  | |    | || |  | | .   |
 / ____ \| |     | |  | |____| |\  |  | |   _| || |__| | |\  |
/_/    \_\_|     |_|  |______|_| \_|  |_|  |_____\____/|_| \_|

--------------------------------------------------------------
YOU NEED TO RE-LOGIN IN ORDER TO APPLY NEW USER PERMISSIONS AND
                ENVIRONMENT VARIABLES. THANK YOU!!
--------------------------------------------------------------
"""