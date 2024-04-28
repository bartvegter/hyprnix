{ config, lib, pkgs, ... }:

{
  options = {
    nvim.enable = lib.mkEnableOption "Enables nvim";
  };

  config = lib.mkIf config.nvim.enable {

    programs.neovim = {
      enable = false;
      extraConfig = lib.fileContents ../hyprland/dotfiles/.config/nvim/init.lua;
    };

    home.packages = with pkgs; [
      fd
      ripgrep
      tree-sitter
    ];

  };
}
