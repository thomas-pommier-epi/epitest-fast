#!/bin/bash

if ! id -nG "$USER" | grep -qw "docker"; then
    echo "[ERROR] : You ($USER) must be in the docker group."
    echo "          Here's the command :"
    echo "          sudo usermod -a -G docker $USER"
    echo "          After this, log out or reboot."
    exit 1
fi

docker pull fedora:36
docker build -t thomas-pommier-epi/epitest-fast:devel .

if [[ $? -eq 0 ]]; then
    echo "Done building."
else
    echo "Failed to build docker image."
    exit 1
fi
