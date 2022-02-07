SHELL := /bin/bash

.PHONY: bootstrap
bootstrap: link brew
	@stty sane

.PHONY: link
link:
	@echo "Linking..."
	@stow -v -S \
		zsh \
		git \
		starship

.PHONY: brew
brew:
	@echo "brewing..."
	@echo "  -> updating"
	@brew update
	@brew upgrade

	@echo "  -> installing apps"
	@brew install \
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
		rbenv \
		jq \
		jo \
		node@16 \
		gh \
		shared-mime-info \
		asciinema \
		bat \
		--quiet

	@echo "  -> installing cask apps"
	@brew install --cask \
		iterm2 \
		powershell \
		visual-studio-code \
		keybase \
		--quiet

	@echo "  -> cleaning up"
	@brew cleanup

.PHONY: configure-gpg
configure-gpg:
	@keybase login
	@keybase pgp export | gpg --import
	@keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import