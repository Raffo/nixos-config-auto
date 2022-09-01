{ config, lib, pkgs, ... }:

let sources = import ../../nix/sources.nix; in {
  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.fzf
    pkgs.htop
    pkgs.jq
    pkgs.tree
    pkgs.watch
    pkgs.vim

    pkgs.go
    pkgs.gopls
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };

  home.file.".zshrc".recursive = true;
  home.file.".zshrc".source = pkgs.fetchFromGitHub {
    owner = "Raffo";
    repo = "dotfiles";
    rev = "main";
    sha256 = "AT9StpiePrFQcGEzI7ZI9mFzoNZPJfx6DV19kVcCiEo=";
  } + "/.zshrc";


  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    userName = "Raffaele Di Fazio";
    userEmail = "difazio.raffaele@gmail.com";
  };

  programs.go = {
    enable = true;
    goPath = "go";
    goPrivate = [ "github.com/github" ];
  };

  # programs.neovim = {
  #   enable = true;
  #   # package = pkgs.neovim-nightly;

  #   # plugins = with pkgs; [
  #   #   customVim.vim-cue
  #   #   customVim.vim-fish
  #   #   customVim.vim-fugitive
  #   #   customVim.vim-glsl
  #   #   customVim.vim-misc
  #   #   customVim.vim-pgsql
  #   #   customVim.vim-tla
  #   #   customVim.vim-zig
  #   #   customVim.pigeon
  #   #   customVim.AfterColors

  #   #   customVim.vim-nord
  #   #   customVim.nvim-comment
  #   #   customVim.nvim-lspconfig
  #   #   customVim.nvim-plenary # required for telescope
  #   #   customVim.nvim-telescope
  #   #   customVim.nvim-treesitter
  #   #   customVim.nvim-treesitter-playground
  #   #   customVim.nvim-treesitter-textobjects

  #   #   vimPlugins.vim-airline
  #   #   vimPlugins.vim-airline-themes
  #   #   vimPlugins.vim-eunuch
  #   #   vimPlugins.vim-gitgutter

  #   #   vimPlugins.vim-markdown
  #   #   vimPlugins.vim-nix
  #   #   vimPlugins.typescript-vim
  #   # ];

  #   extraConfig = (import ./vim-config.nix) { inherit sources; };
  # };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

}
