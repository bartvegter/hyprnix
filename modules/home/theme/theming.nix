{ config, lib, pkgs, ... }:

{
  options = {
    theming.enable = lib.mkEnableOption "Enables theming";
  };

  config = lib.mkIf config.theming.enable {

    home.file = {
      # ".Xresources".source = ./dotfiles/.Xresources;
      ".config/color-scheme/" = {
        source = ./color-scheme;
        recursive = true;
      };
    };

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
      };
    };

    qt = {
      enable = true;
    };

    home.sessionVariables = {
      GDK_BACKEND = "wayland, x11";
      QT_QPA_PLATFORM = "wayland";
    };

    home.packages = with pkgs; [
      gtk-engine-murrine
      xorg.xrdb
    ];
  };

}
