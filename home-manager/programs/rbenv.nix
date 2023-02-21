# rbenv settings

{ outputs, config, lib, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.rbenv
  ];

  programs.rbenv = {
    enable = true;
    plugins = [
      {
        name = "ruby-build";
        src = pkgs.fetchFromGitHub {
          owner = "rbenv";
          repo = "ruby-build";
          rev = "v20230208.1";
          hash = "sha256-Kuq0Z1kh2mvq7rHEgwVG9XwzR5ZUtU/h8SQ7W4/mBU0=";
        };
      }
    ];
  };
}
