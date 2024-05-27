{ config, lib, pkgs, ... }:

{
  options = {
    theming.enable = lib.mkEnableOption "Enables theming";
  };

  config = lib.mkIf config.theming.enable {

    home.file = {
      ".config/color-scheme/" = {
        source = ../hyprland/dotfiles/.config/color-scheme;
        recursive = true;
      };
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.gruvbox-gtk-theme;
        name = "Gruvbox-Dark-BL";
      };
      iconTheme = {
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 24;
    };

    fonts.fontconfig.enable = true;
    gtk.font = {
      name = "Noto Sans SemiCondensed";
      size = 11;
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };

    home.sessionVariables = {
      GDK_BACKEND = "wayland, x11";
      QT_QPA_PLATFORM = "wayland";
    };

    home.packages = with pkgs; [
      gtk-engine-murrine
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      xorg.xrdb
    ];
  };

}
