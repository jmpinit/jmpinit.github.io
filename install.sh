#!/bin/bash

# Exit on any error
set -o errexit

function finish {
  echo "Nothing left to do. Exiting..."
  exit
}

# Ensure that Vim is installed
command -v vim >/dev/null 2>&1 || {
  read -p "Vim is not installed. Install it (y/n)? " -n 1 -r
  echo # New line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo apt-get install vim
  else
    finish
  fi
}

# Overwrite .vimrc
curl -L https://raw.githubusercontent.com/jmptable/jmptable.github.io/master/dotfiles/.vimrc > $HOME/.vimrc

# Set vim as system default editor
update-alternatives --set editor /usr/bin/vim.basic

finish
