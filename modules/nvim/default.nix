{ pkgs, colorscheme, nixpkgs_codelldb_fixed_on_mac, ... }:
let
    # Using a fixed version of codelldb which works on Mac.
    # We get this from an alternate nixpkgs repo.
    # Caveat: This requires Xcode.app installed on the system
    # NOTE: https://github.com/NixOS/nixpkgs/pull/211321
    code_lldb = nixpkgs_codelldb_fixed_on_mac.vscode-extensions.vadimcn.vscode-lldb;
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Appearance
      bufferline-nvim
      indent-blankline-nvim
      lualine-nvim
      alpha-nvim
      nvim-colorizer-lua
      nvim-headlines
      nvim-web-devicons
      noice-nvim

      # Appearance: Themes
      dracula-vim
      one-nvim
      tokyonight-nvim
      catppuccin-nvim

      # DAP
      nvim-dap
      nvim-dap-python
      nvim-dap-ui

      # File Tree
      nvim-tree-lua

      # Fuzzy Finder
      cheatsheet-nvim
      nvim-better-digraphs
      telescope-fzf-native-nvim
      telescope-nvim

      # General Deps
      nui-nvim
      plenary-nvim
      popup-nvim

      # Git
      gitsigns-nvim
      vim-fugitive

      # Programming: LSP
      lspkind-nvim
      null-ls-nvim
      nvim-lspconfig
      lspsaga-nvim-original
      nvim-sqls

      # Progrmming: Treesitter
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        bash
        c
        css
        dhall
        dockerfile
        elm
        go
        haskell
        hcl
        html
        java
        javascript
        json
        latex
        lua
        markdown
        markdown-inline
        nix
        python
        regex
        regex
        ruby
        rust
        scss
        sql
        terraform
        toml
        tsx
        typescript
        vim
        yaml
      ]))
      nvim-nu
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      which-key-nvim

      # Programming: Language support
      crates-nvim
      yuck-vim
      rust-tools-nvim

      # Programming: Autocompletion setup
      nvim-cmp
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-treesitter
      cmp-vsnip
      vim-vsnip
      vim-vsnip-integ

      # Programming: AI shit
      nvim-codeium # AI completion prediction
      ChatGPT-nvim

      # Programming: Database support
      vim-dadbod
      vim-dadbod-ui

      ## Project management
      direnv-vim
      project-nvim

      # Text Helpers
      nvim-regexplainer
      todo-comments-nvim
      venn-nvim
      vim-haskellConcealPlus
      vim-table-mode

      # Text objects
      nvim-autopairs
      nvim-comment
      nvim-surround
    ];

    extraPackages = with pkgs;
      [
        # Bash
        nodePackages.bash-language-server
        shellcheck

        # dhall
        dhall-lsp-server

        # Docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint

        # elm
        elmPackages.elm-language-server
        elmPackages.elm
        elmPackages.elm-test
        elmPackages.elm-format

        # grammer
        vale

        # Git
        gitlint

        # Go
        gopls

        # HTML/CSS/JS
        nodePackages.vscode-langservers-extracted

        # JavaScript
        nodePackages.typescript-language-server

        # lua
        luaformatter
        lua-language-server

        # Make
        /* cmake-language-server */

        # Markdown
        nodePackages.markdownlint-cli
        # This is a cli utility as we can't display all this in cli
        pandoc

        # Nix
        deadnix
        statix
        nil

        # rust
        code_lldb

        # SQL
        sqls
        postgresql

        # terraform
        terraform-lsp

        # TOML
        taplo-cli

        # Vimscript
        nodePackages.vim-language-server

        # YAML
        nodePackages.yaml-language-server
        yamllint

        # general purpose / multiple langs
        efm-langserver
        nodePackages.prettier

        # utilities used by various programs
        # telescope
        ripgrep
        fd

      ] ++ (if pkgs.stdenv.isLinux then [
        # Grammer
        # Not available on mac using brew to install it
        ltex-ls
      ] else [

      ]);


    extraConfig = ''
      colorscheme catppuccin-macchiato
      luafile ${builtins.toString ./init_lua.lua}
    '';
  };

  home.packages = with pkgs; [
    nodePackages.livedown

    # Haskell
    haskellPackages.haskell-language-server


    # Rust
    rust-analyzer
    rustfmt
    clippy

    # python
    python3Packages.isort
    nodePackages.pyright
    black
    python3Packages.flake8
    mypy
  ];

  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/lua/injected.lua".text = ''
    local extension_path = '${code_lldb}/share/vscode/extensions/vadimcn.vscode-lldb/'
    return {
        codelldb_path = extension_path .. 'adapter/codelldb',
        liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
    }
    '';
    "nvim/init_lua.lua".source = ./init_lua.lua;
  };

  home.file.".vale.ini".source = ./vale.ini;
  home.file.".markdownlintrc".source = ./markdown_lint.json;
}
