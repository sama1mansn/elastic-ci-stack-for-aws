#!/bin/bash

set -eu -o pipefail

sudo apt install silversearcher-ag

curl https://sh.rustup.rs -sSf > rust-install.sh

chmod +x rust-install.sh

sudo bash -c "\
  export CARGO_HOME=/usr/local; \
  export RUSTUP_HOME=/usr/local; \
  ./rust-install.sh --no-modify-path -y; \
  rustup install stable; \
  rustup default stable; \
"
rm -rf rust-install.sh

