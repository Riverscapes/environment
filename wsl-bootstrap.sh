#!/bin/bash
# Fail if any step fails
set -eu

# Some preliminary dependencies
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt-get install curl wget git build-essential libssl-dev gcc g++ make zsh vim -y
sudo apt-get install software-properties-common awscli locales -y

# Python
sudo apt-get install python3-pip python-numpy proj-data proj-bin -y
sudo apt-get install gdal-bin libgdal-dev libspatialindex-dev -y
sudo apt-get install python3-matplotlib -y
pip3 install virtualenv

# Node install
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Now setup Node
mkdir "${HOME}/.npm-packages"
npm config set prefix "${HOME}/.npm-packages"
npm install -g npm yarn @riverscapes/cli

# Git and coding area
mkdir ~/code
read -p "Enter Git Email (aaa@bbb.ccc): "  email
read -p "Enter Git Name (John Smith): "  name
git config --global user.email $email
git config --global user.name $name

# Now we build TauDEM
# Prerequisites first:
sudo apt-get update && sudo apt-get install -y cmake mpich \
    libgtest-dev libboost-test-dev libnetcdf-dev
# Clone the right version of TauDEM
git clone --depth 1 -b v5.3.8 https://github.com/dtarb/taudem.git ~/code/taudem
## Compile Main taudem repo ##
mkdir -p  ~/code/taudem/bin
cd ~/code/taudem/src
make


# Now install Oh-my-sh
# Now install Oh-my-sh
echo "------------------------------------------------"
echo "Now we're going to install OhMyZsh."
echo "Follow the instructions and type 'exit' when it drops you into that prompt"
echo "------------------------------------------------"
read -p "(enter to continue)"  nope

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# Import a few config files to make things the same
wget https://raw.githubusercontent.com/MattReimer/environment/master/nar-ys.zsh-theme -O ~/.oh-my-zsh/custom/themes/nar-ys.zsh-theme
wget https://raw.githubusercontent.com/MattReimer/environment/master/.aliases -O ~/.aliases
wget https://raw.githubusercontent.com/MattReimer/environment/master/.zshrc -O ~/.zshrc
