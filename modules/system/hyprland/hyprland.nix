{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    environment.sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      cliphist
      grimblast
      hyprcursor
      hyprlock
      hyprpaper
      hyprpicker
      killall
      kitty
      libnotify
      wl-clip-persist
      wl-clipboard
      xdg-desktop-portal-gtk
    ];

  };
}
