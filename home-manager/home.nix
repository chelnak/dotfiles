with builtins;

{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./programs/bat.nix
    ./programs/exa.nix
    ./programs/fzf.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/go.nix
    ./programs/gpg.nix
    ./programs/jq.nix
    ./programs/kitty.nix
    ./programs/neovim.nix
    ./programs/rbenv.nix
    ./programs/starship.nix
    ./programs/zsh.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = false;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "craig.gumbley";
    homeDirectory = "/Users/craig.gumbley";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Allow font management
  fonts.fontconfig.enable = true;

  # Install some misc packages
  home.packages = with pkgs; [
    coreutils
    httpie
    jo
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    nodejs-19_x
    shared-mime-info
    step-cli
    tree
    wget
    watch
    yq
    # vagrant # out of date
  ];

  # Create a hush login file
  home.file = {
    ".hushlogin" = {
      text = "#";
    };
  };

  # Copy across neovim configs
  home.file = {
    ".config/nvim/lua" = {
      source = ../neovim/lua;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
