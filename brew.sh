#!/bin/bash

echo "brewing..."
echo "  -> updating"
brew update
brew upgrade

echo "  -> installing apps"
brew install \
    zsh \
    bash \
    azure-cli \
    pyenv \
    starship \
    gnupg \
    httpie \
    git \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    tree \
    coreutils \
    stow \
    tfenv \
    --quiet

echo "  -> installing cask apps"
brew install --cask \
    iterm2 \
    powershell \
    visual-studio-code \
    google-chrome \
    keybase \
    1password \
    slack \
    --quiet

echo "  -> cleaning up"
brew cleanup