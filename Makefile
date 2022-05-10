SHELL := /bin/bash

.PHONY: bootstrap
bootstrap: link brew
	@stty sane

.PHONY: link
link:
	@echo "Linking..."
	@stow --no-folding -S \
		zsh \
		git \
		starship \
		neovim

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
		yq \
		node@16 \
		gh \
		shared-mime-info \
		asciinema \
		bat \
		exa \
		golang \
		golanglint-ci \
		libomp \
		wget \
		neovim \
		watch
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