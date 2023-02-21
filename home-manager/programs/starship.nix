# starship settings

{ config, lib, pkgs, ... }:

{
  # https://starship.rs/installing/#nix
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$python$golang$ruby$line_break$directory$git_branch$git_status$line_break$character";
      character = {
        success_symbol  = "[](green)";
        error_symbol    = "[](red)";
      };
      directory = {
        format  = " [$path]($style) ";
      };
      git_branch = {
        symbol = " ";
        format = "on [$symbol$branch ]($style)";
      };
      git_status = {
        format  = "[$all_status$ahead_behind](red)";
        conflicted = "⚔️ ";
        staged  = "~$count";
        ahead   = "⇡$count";
        behind  = "⇣$count";
        diverged    = "⇡$ahead_count⇣$behind_count";
        stashed = "≡";
      };
      python = {
        symbol = "[]($style)";
        format = "[\\[[$symbol $version $virtualenv](dimmed)\\]](dimmed)";
      };
      golang = {
        symbol = "[]($style)";
        format = "'[\\[[$symbol $version](dimmed)\\]](dimmed)'";
      };
      ruby = {
        symbol = "[]($style)";
        format = "[\\[[$symbol $version](dimmed)\\]](dimmed)";
      };
    };
  };
}
