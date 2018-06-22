#!/bin/bash

set -eu -o pipefail -x

wget https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64.deb

sudo dpkg -i cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64.deb
sudo apt-key add /var/cuda-repo-9-2-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda

wget https://developer.nvidia.com/compute/cuda/9.2/Prod/patches/1/cuda-repo-ubuntu1604-9-2-local-cublas-update-1_1.0-1_amd64
sudo dpkg -i cuda-repo-ubuntu1604-9-2-local-cublas-update-1_1.0-1_amd64

readlink /usr/local/cuda
