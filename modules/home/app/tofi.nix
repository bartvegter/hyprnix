{ config, lib, pkgs, ... }:

{
  options = {
    tofi.enable = lib.mkEnableOption "Enables tofi";
  };

  config = lib.mkIf config.tofi.enable {

    home.packages = with pkgs; [
      tofi
    ];

    home.file = {
      ".config/tofi/" = {
        source = ../hyprland/dotfiles/.config/tofi;
        recursive = true;
      };
    };

  };
}
