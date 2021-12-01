#!/bin/bash

. brew.sh

echo "Linking dotfiles..."
stow -v -S \
    zsh \
    git \
    starship \