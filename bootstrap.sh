#!/bin/bash

set -eux

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt-get install curl wget git build-essential libssl-dev gcc g++ make -y
sudo apt-get install zsh git vim

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

# ZSH
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# Import a few config files to make things the same
wget https://raw.githubusercontent.com/MattReimer/environment/master/nar-ys.zsh-theme -O ~/.oh-my-zsh/custom/themes/nar-ys.zsh-theme
wget https://raw.githubusercontent.com/MattReimer/environment/master/.aliases -O ~/.aliases
wget https://raw.githubusercontent.com/MattReimer/environment/master/.zshrc -O ~/.zshrc