SHELL := /bin/bash

.PHONY: bootstrap
bootstrap: link brew
	@stty sane

.PHONY: link
link:
	@echo "Linking..."
	@stow --no-folding -S \
		tmux \
		zsh \
		git \
		starship \
		neovim \
		hushlogin \
		kitty

.PHONY: brew
brew:
	@echo "brewing..."
	@brew bundle
.PHONY: configure-gpg
configure-gpg:
	@keybase login
	@keybase pgp export | gpg --import
	@keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import
