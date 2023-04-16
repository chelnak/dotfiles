# neovim settings
{ config, lib, pkgs, ... }:

let
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      fd
      golangci-lint
      lazygit
      luajit
      nodejs-19_x
      ripgrep
      solargraph
      tree-sitter
      yamllint
    ];
  };
}
