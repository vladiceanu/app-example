#!/usr/bin/env bash

apt-get update -y -qqq
apt install snapd  -y -qqq
snap install core
snap install microk8s --classic --stable

# set snap to the PATH
if [[ ! $PATH =~ "/snap/bin" ]]; then
    echo "Adding '/snap/bin' to PATH."
    export PATH=$PATH:/snap/bin
fi

microk8s.enable helm

# check whether microk8s is running
is_microk8s_ready () {
  for i in $(seq 1 2); do
    output=$(microk8s.status --wait-ready | grep "microk8s is running")
    if [[ $output =~ "microk8s is running" ]]; then
      return 0
    else
      echo "microk8s is not running. Retrying in 5 seconds.."
      sleep 5
    fi
  done
  return 1
}

if ! is_microk8s_ready; then
  echo "Failed to initialize microk8s"
  exit 1
fi

# install docker
apt -y -qqq install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common 

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get -y -qq install docker-ce