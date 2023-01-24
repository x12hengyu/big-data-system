#!/bin/bash

# Docker section
if [[ $(which docker) && $(docker --version) ]]; then
    echo "Docker already installed"
  else
    echo "Install docker"
    # install docker, adapted from https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get update

    sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # install docker engine
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo docker run hello-world
fi

# Java
if [[ $(which java) ]]; then
    echo "Java already installed"
    java -version
  else
    echo "Install java"
    sudo apt-get install openjdk-8-jdk
    java -version
fi

# Cassandra, adapted from https://www.hostinger.com/tutorials/set-up-and-install-cassandra-ubuntu/
if [[ $(which cassandra) ]]; then
    echo "Cassandra already installed"
  else
    wget -q -O - https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
    echo "deb http://www.apache.org/dist/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list deb http://www.apache.org/dist/cassandra/debian 40x main

    sudo apt-get update
    sudo apt install cassandra -y

    sudo systemctl enable cassandra
    sudo systemctl start cassandra
    sudo systemctl status cassandra
fi


