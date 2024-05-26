{ config, lib, ... }:

{
  options = {
    dotfiles.enable = lib.mkEnableOption "Enables dotfiles";
  };

  config = lib.mkIf config.dotfiles.enable {

    home.file = {
      ".config/Thunar/uca.xml".source = ./dotfiles/.config/Thunar/uca.xml;
      ".Xresources".source = ./dotfiles/.Xresources;
    };

  };
}
