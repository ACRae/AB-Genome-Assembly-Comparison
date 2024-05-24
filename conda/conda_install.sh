#!/bin/bash

# Attempt to run a harmless command with sudo
if sudo -n true 2>/dev/null; then
  echo "The user $(whoami) has sudo privileges."
else
  echo "The user $(whoami) does NOT have sudo privileges."
fi

chmod -c 666 ./conda_home.sh

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

sudo cp ./conda_home.sh /etc/profile.d
