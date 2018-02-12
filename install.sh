#!/bin/bash

# Exit on any error
set -o errexit

function finish {
  echo "Nothing left to do. Exiting..."
  exit
}

# Ensure that Vim is installed
command -v vim >/dev/null 2>&1 || {
  echo "Vim is not installed. Installing it now."
  sudo apt-get install vim
}

# Overwrite .vimrc
echo "Overwriting ~/.vimrc."
curl -L https://raw.githubusercontent.com/jmptable/jmptable.github.io/master/dotfiles/.vimrc > $HOME/.vimrc

# Set vim as system default editor
echo "Setting Vim as the default editor."
update-alternatives --set editor /usr/bin/vim.basic

# Install zsh
echo "Installing zsh and oh-my-zsh."
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

finish
