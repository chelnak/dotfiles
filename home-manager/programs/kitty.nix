# kitty settings

{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "FiraCode Nerd Font Mono";
      modify_font = "underline_position = 1";
      cursor_shape = "beam";
      cursor_blink_interval = "0";
      enable_audio_bell = "no";
      confirm_os_window_close = "0";
      tab_title_template = "{index}: {title}";
      tab_bar_style = "powerline";
    };
    extraConfig = "map ctrl+shift+enter new_window_with_cwd";
  };
}
