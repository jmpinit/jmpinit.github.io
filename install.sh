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

function command_exists {
  type "$1" &> /dev/null
}

function install_package {
  # Update package listings once before installing any packages
  if [ -z ${PACKAGES_UPDATED+x} ]; then
    if [[ "$PLATFORM" == "linux" ]]; then
      sudo apt-get update --fix-missing
    elif [[ "$PLATFORM" == "macos*" ]]; then
      if ! command_exists brew; then
        # Install Homebrew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      fi

      brew update
    fi

    PACKAGES_UPDATED=1
  fi

  if [[ "$PLATFORM" == "linux" ]]; then
    sudo apt-get install -y $1
  elif [[ "$PLATFORM" == "macos" ]]; then
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

function install_nodejs {
  echo "Installing Node.js"

  if [[ "$PLATFORM" == "linux" ]]; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt-get install -y nodejs
  elif [[ "$PLATFORM" == "macos" ]]; then
    curl -L https://nodejs.org/dist/v8.12.0/node-v8.12.0.pkg > $HOME/Downloads/nodejs.pkg
    sudo installer -pkg $HOME/Downloads/nodejs.pkg -target /
  else
    echo "Unable to install node.js on this platform"
  fi
}

function install_common {
  install_package git
  install_package vim
  
  configure_vim
  set_vim_as_default
  install_zsh

  install_nodejs

  # TLDR
  echo "Installing tldr for easy information about commands"
  sudo npm install -g tldr
}

function install_linux {
  # Nothing yet
  echo
}

function install_macos {  
  install_package ripgrep

  pushd $HOME/Downloads

  # iTerm
  if [ ! -f /Applications/iTerm.app ]; then
    echo "Installing iTerm, a better terminal"
    curl -L https://iterm2.com/downloads/stable/latest > $HOME/Downloads/iterm.zip
    unzip ./iterm.zip
    cp -r iTerm.app /Applications
  else
    echo "Not installing iTerm because it is already present"
  fi

  # Spectacle
  if [ ! -f /Applications/Spectacle.app ]; then
    echo "Installing Spectacle for window management"
    curl -L https://s3.amazonaws.com/spectacle/downloads/Spectacle+1.2.zip > $HOME/Downloads/Spectacle.zip
    unzip ./Spectacle.zip
    cp -r Spectacle.app /Applications
  else
    echo "Not installing Spectacle because it is already present"
  fi

  # Karabiner
  if [ ! -f /Applications/Karabiner.app ]; then
    echo "Installing Karabiner for key switching"
    curl -L https://pqrs.org/osx/karabiner/files/Karabiner-Elements-12.1.0.dmg > $HOME/Downloads/Karabiner.dmg
    sudo hdiutil attach ./Karabiner.dmg
    sudo installer -pkg /Volumes/Karabiner*/*.pkg -target /
    sudo hdiutil detach /Volumes/Karabiner*
  else
    echo "Not installing Karabiner because it is already present"
  fi

  # Exit ~/Downloads
  popd
}

function install_windows {
  echo "Install SharpKeys from https://github.com/randyrants/sharpkeys/releases"
  echo "Run SharpKeys and swap escape with caps lock"
}

function do_everything {
  trap finish EXIT

  # Identify the platform

  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    PLATFORM=linux
  elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    PLATFORM=linux
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM=macos
  else
    echo "Unknown platform. Halting installation."
    exit 1
  fi

  install_common

  if [[ "$PLATFORM" == "linux" ]]; then
    install_linux
  elif [[ "$PLATFORM" == "macos" ]]; then
    install_macos
  elif [[ "$PLATFORM" == "windows" ]]; then
    install_windows
  else
    echo "Unknown OS type: $OSTYPE"
    echo "Stopping installation"
  fi

  echo "Done!"

  if [[ "$PLATFORM" == "macos" ]]; then
    echo
    echo "Manual steps:"
    echo "\t( ) Open Spectacle and enable accessibility feature access"
    echo "\t( ) Configure Karabiner to switch the Caps-Lock and Escape keys"
  fi
}

do_everything
