#!/bin/bash
# Fail if any step fails
set -eu

# Some preliminary dependencies
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt-get install curl wget git build-essential libssl-dev gcc g++ make zsh vim -y
sudo apt-get install software-properties-common unzip locales -y

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
# Clean up
rm -rf awscliv2.zip ./aws

# Python
sudo apt-get install python3-pip proj-data proj-bin -y
sudo apt-get install gdal-bin libgdal-dev libspatialindex-dev -y
sudo apt-get install python3-matplotlib -y

# Now install Oh-my-sh
echo "------------------------------------------------"
echo "Now we're going to install OhMyZsh."
echo "Follow the instructions and type 'exit' when it drops you into that prompt"
echo "------------------------------------------------"
read -p "(enter to continue)"

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# Import a few config files to make things the same
wget https://raw.githubusercontent.com/Riverscapes/environment/master/nar-ys.zsh-theme -O ~/.oh-my-zsh/custom/themes/nar-ys.zsh-theme
wget https://raw.githubusercontent.com/Riverscapes/environment/master/.aliases -O ~/.aliases
wget https://raw.githubusercontent.com/Riverscapes/environment/master/.zshrc -O ~/.zshrc

# Node install via NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
# Now add v18 
nvm install v18
nvm alias default v18

# Git and coding area
read -p "Enter Git Email (aaa@bbb.ccc): "  email
read -p "Enter Git Name (John Smith): "  name
git config --global user.email $email
git config --global user.name $name

# Now setup Node
mkdir "${HOME}/.npm-packages"
npm config set prefix "${HOME}/.npm-packages"
# Install the riverscapes CLI
npm install -g npm yarn @riverscapes/cli
