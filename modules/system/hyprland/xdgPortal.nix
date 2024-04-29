{ config, lib, pkgs, ... }:

{
  options = {
    xdgPortal.enable = lib.mkEnableOption "Enables xdgPortal";
  };

  config = lib.mkIf config.xdgPortal.enable {

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };

  };
}
