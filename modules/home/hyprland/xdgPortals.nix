{ config, lib, pkgs, ... }:

{
  options = {
    xdgPortals.enable = lib.mkEnableOption "Enables xdgPortals";
  };

  config = lib.mkIf config.xdgPortals.enable {

    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
        configPackages = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
        xdgOpenUsePortal = true;
      };
    };

  };
}
