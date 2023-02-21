# jq settings

{ config, lib, pkgs, ... }:

{
  programs.jq = {
    enable = true;
  };
}
