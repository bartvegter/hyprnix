{ config, lib, pkgs, ... }:

{
  options = {
    gtkTheme.enable = lib.mkEnableOption "Enables gtkTheme";
  };

  config = lib.mkIf config.gtkTheme.enable {

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur Cursors";
      size = 24;
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

      # cursorTheme = {
      #   package = pkgs.whitesur-cursors;
      #   name = "WhiteSur Cursors";
      # };

      font = {
        name = "Noto Sans SemiCondensed";
        size = 11;
      };
    };

    # Makes QT follow GTK theme
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };

  };
}
