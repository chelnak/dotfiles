# git settings

{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Craig Gumbley";
    userEmail = "craiggumbley@gmail.com";
    signing = {
      key = "AC2291CF29056C5C";
      signByDefault = true;
    };
    extraConfig = {
      push = {
        default = "current";
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        colorMoved = "zebra";
      };
      fetch = {
        prune = true;
      };
    };
    ignores = [
      ".DS_Store"
      "**/**/*.deb"
      "**/dist"
      "**/build"
      "**/__pycache__"
      "**/*.spec"
      "*.log"
    ];
    aliases = {
      branchr = "!git_branch_recent() { refbranch=$1 count=$2; git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' --color=always --count=\${count:-20} | while read line; do branch=$(echo $line | awk 'BEGIN { FS = \"|\" }; { print $1 }' | tr -d '*'); ahead=$(git rev-list --count \${refbranch:-origin/main}..\${branch}); behind=$(git rev-list --count \${branch}..\${refbranch:-origin/main}); colorline=$(echo $line | sed 's/^[^|]*|//'); echo \"$ahead|$behind|$colorline\" | awk -F'|' -vOFS='|' '{$5=substr($5,1,70)}1' ; done | (echo \"ahead|behind||branch|lastcommit|message|author\" && cat) | column -ts'|';}; git_branch_recent";
    };
  };
}
