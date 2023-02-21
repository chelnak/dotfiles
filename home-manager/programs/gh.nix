# gh cli settings

{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    settings = {
      git_protocol = "https";
    };
  };
}
