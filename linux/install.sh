#!/bin/bash
SOURCE="https://github.com/chelnak/dotfiles"
TARGET="$HOME/.dotfiles"

INSTALL="git clone $SOURCE $TARGET"
UPDATE="git pull"

if [ -d "$TARGET" ]; then
  echo "Updating dotfiles"
  cd $TARGET
  eval "$UPDATE"
else
  echo "Installing dotfiles"
  mkdir -p "$TARGET"
  eval "$INSTALL"
  sudo apt install make
fi
