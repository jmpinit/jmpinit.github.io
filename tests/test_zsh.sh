#!/bin/bash

OH_MY_ZSH_OWNER=$(stat -c '%U' "$HOME/.oh-my-zsh")
ZSHRC_OWNER=$(stat -c '%U' "$HOME/.zshrc")

if [ "$OH_MY_ZSH_OWNER" != "$USER" ]; then
  echo .oh-my-zsh directory is not owned by the correct user
  exit 1
fi

if [ "$ZSHRC_OWNER" != "$USER" ]; then
  echo .zshrc is not owned by the correct user
  exit 1
fi

