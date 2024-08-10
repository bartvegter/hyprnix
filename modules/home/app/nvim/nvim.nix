{ config, lib, pkgs, ... }:

{
  options = {
    nvim.enable = lib.mkEnableOption "Enables nvim";
  };

  config = lib.mkIf config.nvim.enable {

    stylix.targets.neovim.enable = false;

    programs.neovim = {
      enable = true;
      coc.enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraLuaConfig = lib.fileContents ./init.lua;
    };

    home.packages = with pkgs; [
      fd
      ripgrep
      tree-sitter
    ];

  };
}
