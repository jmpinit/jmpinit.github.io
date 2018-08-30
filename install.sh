#!/bin/bash

# Exit on any error
set -o errexit

function finish {
  echo "Nothing left to do. Exiting..."
  exit
}

# TODO: Tools
# * ripgrep
# * tldr
# * Spectacle
# * VS Code
#   - Install shell command
# * Karabiner
#   - Switch caps lock with escape
# * iTerm
#   - Reuse previous session's directory

sudo apt-get update --fix-missing

sudo apt-get install -y git vim

# Overwrite .vimrc
echo "Overwriting ~/.vimrc."
curl -L https://raw.githubusercontent.com/jmptable/jmptable.github.io/master/dotfiles/.vimrc > $HOME/.vimrc

# Set vim as system default editor
echo "Setting Vim as the default editor."
sudo update-alternatives --set editor /usr/bin/vim.basic

# Install zsh
echo "Installing zsh and oh-my-zsh."
sudo apt-get install -y zsh
sudo -E sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Done!"
