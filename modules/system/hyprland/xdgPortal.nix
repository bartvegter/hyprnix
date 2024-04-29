{ config, lib, ... }:

{
  options = {
    xdgPortal.enable = lib.mkEnableOption "Enables xdgPortal";
  };

  config = lib.mkIf config.xdgPortal.enable {

    xdg.portal = {
      enable = true;
      extraPortals = [ "xdg-desktop-portal-hyprland" "xdg-desktop-portal-gtk" ];
      xdgOpenUsePortal = true;
    };

  };
}
