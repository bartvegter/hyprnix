{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents ./dotfiles/.config/nvim/init.lua;
  };

  home.packages = with pkgs; [
    ripgrep
    tree-sitter
  ];
}
