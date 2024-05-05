{ config, lib, ... }:

{
  options = {
    dotfiles.enable = lib.mkEnableOption "Enables dotfiles";
  };

  config = lib.mkIf config.dotfiles.enable {

    home.file = {
      ".config/homepage/" = {
        source = ./dotfiles/.config/homepage;
        recursive = true;
      };

      ".config/Thunar/" = {
        source = ./dotfiles/.config/Thunar;
        recursive = true;
      };
    };

  };
}
