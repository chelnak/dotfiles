# neovim settings
{ config, lib, pkgs, ... }:

let
  # fromGitHub is a utility function that allows you to pull a vim plugin from GitHub
  #
  # @param owner: The name of the organisation/owner
  # @param repo: The name of the repo
  # @param hash: A sha256 sum of the artifact
  # @param rev: The branch sha or tag to fetch (default: main)
  # @param as: An optional argument to allow plugin aliasing to avoid conflicts
  fromGitHub = {
    owner,
    repo,
    hash,
    rev ? "main",
    as ? repo,
  }:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName as}";
      version = rev;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = rev;
        hash = hash;
      };
    };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
    plugins = with pkgs.vimPlugins; [
      auto-save-nvim
      cmp-buffer
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      comment-nvim
      copilot-vim
      feline-nvim
      friendly-snippets
      gitsigns-nvim
      indent-blankline-nvim
      lazygit-nvim
      lsp-zero-nvim
      luasnip
      mason-lspconfig-nvim
      mason-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-lspconfig
      nvim-tree-lua
      (nvim-treesitter.withPlugins (p: [
            p.bash
            p.go
            p.json
            p.nix
            p.markdown
            p.python
            p.ruby
            p.typescript
            p.yaml
          ]
        )
      )
      nvim-treesitter-context
      nvim-web-devicons
      popup-nvim
      trouble-nvim
      telescope-nvim
      vim-better-whitespace
      vim-devicons
      vim-gitgutter
      vim-go
      vim-polyglot
      vim-puppet
      which-key-nvim

      # Plugins that we pull from source
      (fromGitHub {owner = "tveskag"; repo = "nvim-blame-line"; rev = "master"; hash = "sha256-qDGr6+kxls9y7Ov4Lgp6soZF2M4FbAvQB/sxXtFCHKo=";})
      (fromGitHub {owner = "folke"; repo = "lsp-colors.nvim"; hash = "sha256-cLmQ4Zsr64ua+HQ1NICC3BRq7Z5ADY82L3H00bS7ets=";})
      (fromGitHub {owner = "catppuccin"; repo = "nvim"; rev = "v1.0.0"; hash = "sha256-xvC7412o9mY79Rcfnf1mMq/dVgm7zexuuTvGKy4OehY="; as = "catppuccin";})
    ];

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
