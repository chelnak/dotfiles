# zsh settings

{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      cat   = "bat";
      ls    = "eza --icons --all";
      ll    = "ls --header --long --git";
      tree  = "ll --tree --level=4 --ignore-glob='.git'";
      vim   = "nvim";
      gs    = "git status";
      ssh   = "TERM='xterm-256color' ssh";
      hms   = "home-manager switch --flake ~/code/dotfiles/#$USER";
    };
    sessionVariables = rec {
      DISABLE_AUTO_TITLE = "true";
    };
    initExtra = ''
      export GITHUB_TOKEN="(gh auth token)"
      export GOPATH=$HOME/go
      export PATH="$PATH:$GOPATH/bin"
      export PATH="$PATH:/usr/local/opt/node@16/bin"
      export PATH="$PATH:/opt/homebrew/bin"
      export ZSH="$HOME/.oh-my-zsh"
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
      export NIX_PATH="$NIX_PATH:$NIX_PATH:$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels"

      export EDITOR=nvim

      set_terminal_title
    '';
    envExtra = ''
      set_terminal_title() {
        echo -ne "\033]0;$(basename $PWD)\007"
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "copybuffer"
        "copypath"
        "dirhistory"
        "jsontools"
      ];
    };
  };
}
