# gh cli settings

{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    gitCredentialHelper ={
      enable = true;
    };
    settings = {
      git_protocol = "https";
    };
  };
}
