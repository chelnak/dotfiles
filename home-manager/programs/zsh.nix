# zsh settings

{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      # git   = "gitWrapper";
      cat   = "bat";
      ls    = "exa --icons --all";
      ll    = "ls --header --long --git";
      tree  = "ll --tree --level=4 --ignore-glob='.git'";
      bolt  = "/opt/puppetlabs/bin/bolt";
      vim   = "nvim";
      ppt   = "cd $HOME/code/puppet";
      gs    = "git status";
      gco   = "git checkout";
      gcm   = "git checkout main";
      gcb   = "git checkout -b";
      gpl   = "git pull";
      gps   = "git push";
    };
    sessionVariables = rec {
      DISABLE_AUTO_TITLE = "true";
    };
    initExtra = ''
      export GOPATH=$HOME/go
      export PATH="$PATH:$GOPATH/bin"
      export PATH="$PATH:/usr/local/opt/node@16/bin"
      export PATH="$PATH:$HOME/.rbenv/shims"
      export PATH="$PATH:$HOME/.rbenv/bin"
      export PATH="$PATH:/opt/puppetlabs/bin"
      export ZSH="$HOME/.oh-my-zsh"
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
      export NIX_PATH="$NIX_PATH:$NIX_PATH:$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels"

      export EDITOR=nvim

      eval "$(rbenv init - zsh)"
      set_terminal_title
    '';
    envExtra = ''
      gitWrapper() {
        # Stops you from using git push --force
        if [ "$1" = "push" ] && [ "$2" = "--force" ] || [ "$2" = "-f" ]; then
          echo 'You should use "git push --force-with-lease" instead of "git push --force" to push to remote.'
          return
        fi

        git "$@"
      }

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
