#!/bin/bash

# OSTYPE can be one of:
# - linux-gnu
# - darwin*
# - cygwin
# - msys (part of MinGW, used by Git Bash)
# - win32 (shouldn't happen b/c no Bash)
# - freebsd

# Exit on any error
set -o errexit

function finish {
  if [[ $? -ne 0 ]]; then
    echo "Something went wrong. Please fix the code at https://github.com/jmptable/jmptable.github.io/blob/master/install.sh . Thanks."
  fi

  echo "Nothing left to do. Exiting..."
  exit
}

trap finish EXIT

function install_package {
  # Update package listings once before installing any packages
  if [ -z ${PACKAGES_UPDATED+x} ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
      sudo apt-get update --fix-missing
    elif [[ "$OSTYPE" == "darwin*" ]]; then
      brew update
    fi

    PACKAGES_UPDATED=1
  fi

  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install -y $1
  elif [[ "$OSTYPE" == "darwin*" ]]; then
    brew install $1
  else
    echo "Cannot install $1 on this platform"
  fi
}

function configure_vim {
  # Overwrite .vimrc
  echo "Overwriting ~/.vimrc."
  curl -L https://raw.githubusercontent.com/jmptable/jmptable.github.io/master/dotfiles/.vimrc > $HOME/.vimrc
}

function set_vim_as_default {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Set vim as system default editor
    echo "Setting Vim as the default editor."
    sudo update-alternatives --set editor /usr/bin/vim.basic
  else
    echo "Cannot set vim as default editor on this OS."
  fi
}

function install_zsh {
  # Install zsh
  echo "Installing zsh and oh-my-zsh."
  install_package zsh
  sudo -E sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_common {
  install_package git
  install_package vim
  
  configure_vim
  set_vim_as_default
  install_zsh
}

function install_linux {
  # Nothing yet
  echo
}

function install_windows {
  echo "Install SharpKeys from https://github.com/randyrants/sharpkeys/releases"
  echo "Run SharpKeys and swap escape with caps lock"
}

install_common

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  install_linux
elif [[ "$OSTYPE" == "msys" ]]; then
  install_windows
else
  echo "Unknown OS type: $OSTYPE"
  echo "Stopping installation"
fi

echo "Done!"
