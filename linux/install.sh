#!/usr/bin/env bash

SOURCE="https://github.com/chelnak/dotfiles"
TARBALL="$SOURCE/tarball/master"
TARGET="$HOME/dotfiles"
TAR_CMD="tar -xzv -C "$TARGET" --strip-components=1 --exclude='{.gitignore}'"

is_executable() {
  type "$1" > /dev/null 2>&1
}

if is_executable "git"; then
  CMD="git clone $SOURCE $TARGET"
fi

if [ -z "$CMD" ]; then
  echo "No git. Aborting."
else
  echo "Installing dotfiles..."
  mkdir -p "$TARGET"
  eval "$CMD"
fi
