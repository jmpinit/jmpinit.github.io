#!/bin/bash

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

# Install Pathogen for plugin management
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install NERDTree
pushd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
popd

# Overwrite .vimrc
curl http://sh.owentrueblood.com/dotfiles/.vimrc > $HOME/.vimrc

finish
