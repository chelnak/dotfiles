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
		neovim \
		hushlogin \
		kitty

.PHONY: brew
brew:
	@echo "brewing..."
	@brew bundle
